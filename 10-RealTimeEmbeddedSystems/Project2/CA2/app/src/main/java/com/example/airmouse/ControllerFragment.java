package com.example.airmouse;

import android.content.Context;
import android.graphics.Color;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Trace;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SeekBar;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.example.airmouse.databinding.FragmentControllerBinding;

import java.util.Locale;

public class ControllerFragment extends Fragment implements SensorEventListener {

    private FragmentControllerBinding binding;

    private SensorManager sensorManager;
    private Sensor gyroscope;
    private Sensor accelerometer;
    private Sensor magnetometer;

    private HandlerThread sensorThread;
    private Handler sensorHandler;

    private volatile boolean isRunning = false;
    private volatile boolean isCalibrating = false;

    private final float[] gyroValues = new float[]{0f, 0f, 0f};
    private final float[] accelValues = new float[]{0f, 0f, 0f};
    private final float[] magnetValues = new float[]{0f, 0f, 0f};

    private int sensitivity = 50;

    private float previewX = 0f;
    private float previewY = 0f;

    private UdpMouseClient udpClient;
    private long lastUiUpdateNs = 0L;
    private long lastFallbackMoveNs = 0L;

    private boolean fallbackBaseReady = false;
    private float fallbackBaseAx = 0f;
    private float fallbackBaseAy = 0f;

    private SensorCalibration calibration;
    private final AirMouseMapper mapper = new AirMouseMapper();

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        binding = FragmentControllerBinding.inflate(inflater, container, false);
        return binding.getRoot();
    }

    @Override
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        calibration = SensorCalibration.load(requireContext());
        mapper.setCalibration(calibration);
        setupSensors();
        setupUi();
        updateInitialUi();
    }

    private void setupSensors() {
        Context context = requireContext();
        sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);

        if (sensorManager != null) {
            gyroscope = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE_UNCALIBRATED);
            if (gyroscope == null) {
                gyroscope = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE);
            }

            accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
            magnetometer = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
        }
    }

    private void setupUi() {
        binding.btnStart.setOnClickListener(v -> startController());
        binding.btnStop.setOnClickListener(v -> stopController());

        binding.sensitivitySeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                sensitivity = progress;
                mapper.setSensitivity(progress);
                binding.txtSensitivityValue.setText(String.valueOf(progress));
                updateMotionInfo(0, 0, false, 0);
            }

            @Override public void onStartTrackingTouch(SeekBar seekBar) {}
            @Override public void onStopTrackingTouch(SeekBar seekBar) {}
        });
    }

    private void updateInitialUi() {
        sensitivity = binding.sensitivitySeekBar.getProgress();
        mapper.setSensitivity(sensitivity);
        binding.txtSensitivityValue.setText(String.valueOf(sensitivity));
        binding.txtStatus.setText("Status: Stopped");
        binding.txtStatus.setTextColor(Color.rgb(220, 38, 38));
        binding.txtLog.setText(buildSensorReport() + "\nApp is ready. Enter laptop IP and port, then press Start.\n\nLoaded calibration:\n" + calibration.summary());
        binding.editPort.setText("5000");
        updateMotionInfo(0, 0, false, 0);
        binding.txtGyroBias.setText(mapper.biasText());
    }

    private String buildSensorReport() {
        String gyroName = gyroscope == null ? "NOT FOUND" : gyroscope.getName();
        String accelName = accelerometer == null ? "NOT FOUND" : accelerometer.getName();
        String magnetName = magnetometer == null ? "NOT FOUND" : magnetometer.getName();

        return "Sensors -> Gyro: " + gyroName + " | Accel: " + accelName + " | Magnet: " + magnetName;
    }

    private void startController() {
        if (sensorManager == null) {
            binding.txtStatus.setText("Status: Error");
            binding.txtLog.setText("SensorManager is not available.");
            return;
        }

        if (accelerometer == null) {
            binding.txtStatus.setText("Status: Error");
            binding.txtLog.setText("Accelerometer sensor is not available. This app needs accelerometer at least.\n" + buildSensorReport());
            return;
        }

        if (isRunning) {
            binding.txtLog.setText("Controller is already running.");
            return;
        }

        String host = binding.editIp.getText() == null ? "" : binding.editIp.getText().toString().trim();
        int port = parsePort();

        if (host.isEmpty()) {
            Toast.makeText(requireContext(), "Laptop IP را وارد کن", Toast.LENGTH_SHORT).show();
            binding.txtLog.setText("Laptop IP is empty. Run the Python server and copy the printed IP here.");
            return;
        }

        try {
            udpClient = new UdpMouseClient(host, port);
        } catch (Exception e) {
            binding.txtStatus.setText("Status: Network Error");
            binding.txtLog.setText("Cannot create UDP client: " + e.getMessage());
            return;
        }

        calibration = SensorCalibration.load(requireContext());
        mapper.setCalibration(calibration);
        mapper.resetRuntime();
        previewX = 0f;
        previewY = 0f;
        lastFallbackMoveNs = 0L;
        lastUiUpdateNs = 0L;
        fallbackBaseReady = false;
        binding.motionBox.setTranslationX(0f);
        binding.motionBox.setTranslationY(0f);

        sensorThread = new HandlerThread("AirMouseSensorThread");
        sensorThread.start();
        sensorHandler = new Handler(sensorThread.getLooper());

        isRunning = true;

        if (gyroscope != null) {
            sensorManager.registerListener(this, gyroscope, SensorManager.SENSOR_DELAY_GAME, sensorHandler);
        }
        sensorManager.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_GAME, sensorHandler);
        if (magnetometer != null) {
            sensorManager.registerListener(this, magnetometer, SensorManager.SENSOR_DELAY_GAME, sensorHandler);
        }

        binding.txtStatus.setText("Status: Started");
        binding.txtStatus.setTextColor(Color.rgb(22, 163, 74));
        String modeText = gyroscope == null
                ? "Gyroscope was not found, so movement is using accelerometer fallback. For the final project, use a phone with gyro if possible."
                : "Gyroscope mode is active. Sensor callbacks run on AirMouseSensorThread.";

        binding.txtLog.setText(String.format(Locale.US,
                "%s\nSending UDP packets to %s:%d. Move packets are droppable, click/scroll wait for ACK.\n\nCalibration in use:\n%s",
                modeText, host, port, calibration.summary()));
    }

    private int parsePort() {
        try {
            String text = binding.editPort.getText() == null ? "" : binding.editPort.getText().toString().trim();
            if (text.isEmpty()) return 5000;
            return Integer.parseInt(text);
        } catch (Exception e) {
            return 5000;
        }
    }

    private void stopController() {
        isRunning = false;
        isCalibrating = false;

        if (sensorManager != null) {
            sensorManager.unregisterListener(this);
        }

        if (sensorThread != null) {
            sensorThread.quitSafely();
            sensorThread = null;
            sensorHandler = null;
        }

        if (udpClient != null) {
            udpClient.close();
            udpClient = null;
        }

        if (binding != null) {
            binding.txtStatus.setText("Status: Stopped");
            binding.txtStatus.setTextColor(Color.rgb(220, 38, 38));
            binding.txtLog.setText("Controller stopped.");
            updateMotionInfo(0, 0, false, 0);
        }
    }

    private void startGyroCalibration() {
        if (!isRunning) {
            binding.txtLog.setText("First press Start, then keep the phone still and press Calibrate.");
            return;
        }

        if (gyroscope == null) {
            binding.txtLog.setText("Cannot calibrate gyro because gyroscope was not found on this phone. Accelerometer fallback is active.");
            return;
        }

        isCalibrating = true;
        mapper.beginGyroCalibration();
        binding.txtLog.setText("Gyro calibration started. Keep the phone still for about 2 seconds.");
        binding.getRoot().postDelayed(this::finishCalibrationIfNeeded, 2000);
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        if (!isRunning || event == null || event.sensor == null) return;

        int type = event.sensor.getType();
        String sectionName;

        if (type == Sensor.TYPE_GYROSCOPE || type == Sensor.TYPE_GYROSCOPE_UNCALIBRATED) {
            sectionName = "airmouse_sensor_gyro";
        } else if (type == Sensor.TYPE_ACCELEROMETER) {
            sectionName = "airmouse_sensor_accel";
        } else if (type == Sensor.TYPE_MAGNETIC_FIELD) {
            sectionName = "airmouse_sensor_mag";
        } else {
            sectionName = "airmouse_sensor_other";
        }

        Trace.beginSection(sectionName);
        try {
            if (type == Sensor.TYPE_GYROSCOPE || type == Sensor.TYPE_GYROSCOPE_UNCALIBRATED) {
                handleGyroEvent(event);
            } else if (type == Sensor.TYPE_ACCELEROMETER) {
                handleAccelEvent(event);
            } else if (type == Sensor.TYPE_MAGNETIC_FIELD) {
                handleMagnetEvent(event);
            }
        } finally {
            Trace.endSection();
        }
    }

    private void handleGyroEvent(SensorEvent event) {
        gyroValues[0] = event.values[0];
        gyroValues[1] = event.values[1];
        gyroValues[2] = event.values[2];

        if (isCalibrating) {
            mapper.addGyroCalibrationSample(gyroValues[0], gyroValues[1], gyroValues[2]);
            return;
        }

        float gx = mapper.correctedGyroX(gyroValues[0]);
        float gy = mapper.correctedGyroY(gyroValues[1]);
        float gz = mapper.correctedGyroZ(gyroValues[2]);

        AirMouseMapper.MouseOutput output = mapper.onGyro(event.timestamp, gyroValues[0], gyroValues[1], gyroValues[2]);

        if (output.hasMove() && udpClient != null) {
            Trace.beginSection("airmouse_udp_enqueue_move");
            udpClient.sendMove(output.dx, output.dy);
            Trace.endSection();
            updateMotionPreviewUI(output.dx, output.dy);
        }

        if (output.click && udpClient != null) {
            Trace.beginSection("airmouse_udp_enqueue_click");
            udpClient.sendEvent(true, 0);
            Trace.endSection();
            runOnUiSafe(() -> {
                flashMotionBox();
                updateMotionInfo(output.dx, output.dy, true, 0);
                binding.txtLog.setText("Click event sent. ACK/retry is handled in AirMouseUdpThread.");
            });
        }

        if (event.timestamp - lastUiUpdateNs > 100_000_000L) {
            lastUiUpdateNs = event.timestamp;
            runOnUiSafe(() -> {
                updateGyroText(gx, gy, gz);
                if (!output.click) updateMotionInfo(output.dx, output.dy, false, 0);
            });
        }
    }

    private void handleAccelEvent(SensorEvent event) {
        System.arraycopy(event.values, 0, accelValues, 0, 3);
        int scroll = mapper.onAccelerometer(event.timestamp, accelValues[0], accelValues[1], accelValues[2]);

        float ax = mapper.correctedAccelX(accelValues[0]);
        float ay = mapper.correctedAccelY(accelValues[1]);
        float az = mapper.correctedAccelZ(accelValues[2]);

        if (gyroscope == null && udpClient != null) {
            handleAccelerometerFallbackMove(event.timestamp, ax, ay);
        }

        if (scroll != 0 && udpClient != null) {
            Trace.beginSection("airmouse_udp_enqueue_scroll");
            udpClient.sendEvent(false, scroll);
            Trace.endSection();
            runOnUiSafe(() -> {
                flashMotionBox();
                updateMotionInfo(0, 0, false, scroll);
                binding.txtLog.setText(scroll > 0
                        ? "Scroll up event sent. ACK/retry is handled in AirMouseUdpThread."
                        : "Scroll down event sent. ACK/retry is handled in AirMouseUdpThread.");
            });
        }

        runOnUiSafe(() -> binding.txtAccel.setText(String.format(Locale.US,
                "Accelerometer corrected: x=%.2f y=%.2f z=%.2f",
                ax, ay, az)));
    }

    private void handleMagnetEvent(SensorEvent event) {
        System.arraycopy(event.values, 0, magnetValues, 0, 3);
        float[] corrected = mapper.onMagnetometer(magnetValues[0], magnetValues[1], magnetValues[2]);

        runOnUiSafe(() -> binding.txtMagnet.setText(String.format(Locale.US,
                "Magnetometer corrected: x=%.2f y=%.2f z=%.2f",
                corrected[0], corrected[1], corrected[2])));
    }

    private void handleAccelerometerFallbackMove(long timestampNs, float ax, float ay) {
        if (!fallbackBaseReady) {
            fallbackBaseAx = ax;
            fallbackBaseAy = ay;
            fallbackBaseReady = true;
            return;
        }

        if (timestampNs - lastFallbackMoveNs < 16_000_000L) return;
        lastFallbackMoveNs = timestampNs;

        float gain = 0.8f + sensitivity / 22.0f;
        int dx = Math.round(-(ax - fallbackBaseAx) * gain);
        int dy = Math.round((ay - fallbackBaseAy) * gain);

        if (Math.abs(dx) <= 2) dx = 0;
        if (Math.abs(dy) <= 2) dy = 0;

        dx = Math.max(-35, Math.min(35, dx));
        dy = Math.max(-35, Math.min(35, dy));

        if (dx != 0 || dy != 0) {
            udpClient.sendMove(dx, dy);
            updateMotionPreviewUI(dx, dy);
            final int finalDx = dx;
            final int finalDy = dy;
            runOnUiSafe(() -> updateMotionInfo(finalDx, finalDy, false, 0));
        }
    }

    private void finishCalibrationIfNeeded() {
        if (!isCalibrating || binding == null) return;

        boolean ok = mapper.finishGyroCalibration();
        isCalibrating = false;
        if (ok && getContext() != null) {
            mapper.getCalibration().save(requireContext());
        }
        binding.txtGyroBias.setText(mapper.biasText());
        binding.txtLog.setText(ok
                ? "Gyro calibration completed and saved.\n" + mapper.getCalibration().summary()
                : "Calibration failed. Keep the phone still and try again.");
    }

    private void updateGyroText(float correctedX, float correctedY, float correctedZ) {
        binding.txtGyro.setText(String.format(Locale.US,
                "Gyroscope corrected: x=%.3f y=%.3f z=%.3f | %s",
                correctedX, correctedY, correctedZ, mapper.filterText()));
        binding.txtGyroBias.setText(mapper.biasText());
    }

    private void updateMotionPreviewUI(int dx, int dy) {
        runOnUiSafe(() -> {
            Trace.beginSection("airmouse_ui_update");
            try {
                View parent = (View) binding.motionBox.getParent();
                float maxX = (parent.getWidth() - binding.motionBox.getWidth()) / 2f;
                float maxY = (parent.getHeight() - binding.motionBox.getHeight()) / 2f;

                previewX += dx;
                previewY += dy;

                previewX = Math.max(-maxX, Math.min(maxX, previewX));
                previewY = Math.max(-maxY, Math.min(maxY, previewY));

                binding.motionBox.setTranslationX(previewX);
                binding.motionBox.setTranslationY(previewY);
            } finally {
                Trace.endSection();
            }
        });
    }

    private void flashMotionBox() {
        binding.motionBox.setAlpha(0.25f);
        binding.motionBox.postDelayed(() -> {
            if (binding != null) binding.motionBox.setAlpha(1f);
        }, 90);
    }

    private void updateMotionInfo(int dx, int dy, boolean click, int scroll) {
        binding.txtMotionInfo.setText(String.format(Locale.US,
                "dx: %d | dy: %d | click: %s | scroll: %d | sensitivity: %d",
                dx, dy, click ? "true" : "false", scroll, sensitivity));
    }

    private void runOnUiSafe(Runnable runnable) {
        FragmentControllerBinding current = binding;
        if (current == null) return;
        current.getRoot().post(() -> {
            if (binding != null) runnable.run();
        });
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
    }

    @Override
    public void onPause() {
        super.onPause();
        stopController();
    }

    @Override
    public void onDestroyView() {
        stopController();
        super.onDestroyView();
        binding = null;
    }
}
