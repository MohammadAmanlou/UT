package com.example.airmouse;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.example.airmouse.databinding.FragmentCalibrationBinding;

import java.util.Locale;

public class CalibrationFragment extends Fragment implements SensorEventListener {

    private FragmentCalibrationBinding binding;

    private SensorManager sensorManager;
    private Sensor gyroSensor;
    private Sensor accelSensor;
    private Sensor magSensor;

    private HandlerThread sensorThread;
    private Handler sensorHandler;

    private SensorCalibration calibration;

    private final float[] currentGyro = new float[]{0f, 0f, 0f};
    private final float[] currentAccel = new float[]{0f, 0f, 0f};
    private final float[] currentMag = new float[]{0f, 0f, 0f};

    private boolean collectingGyro = false;
    private final float[] gyroSum = new float[]{0f, 0f, 0f};
    private int gyroCount = 0;

    private int accelCaptureIndex = -1;
    private final float[][] accelPoseSamples = new float[6][3];
    private final boolean[] accelPoseReady = new boolean[6];
    private final float[] accelCaptureSum = new float[]{0f, 0f, 0f};
    private int accelCaptureCount = 0;

    private boolean collectingMag = false;
    private final float[] magMin = new float[]{Float.POSITIVE_INFINITY, Float.POSITIVE_INFINITY, Float.POSITIVE_INFINITY};
    private final float[] magMax = new float[]{Float.NEGATIVE_INFINITY, Float.NEGATIVE_INFINITY, Float.NEGATIVE_INFINITY};
    private int magCount = 0;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        binding = FragmentCalibrationBinding.inflate(inflater, container, false);
        return binding.getRoot();
    }

    @Override
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        calibration = SensorCalibration.load(requireContext());
        setupSensors();
        setupButtons();
        updateSummary();
    }

    @Override
    public void onResume() {
        super.onResume();
        startSensorListeners();
    }

    @Override
    public void onPause() {
        super.onPause();
        stopSensorListeners();
    }

    private void setupSensors() {
        sensorManager = (SensorManager) requireContext().getSystemService(Context.SENSOR_SERVICE);
        if (sensorManager == null) return;

        gyroSensor = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE_UNCALIBRATED);
        if (gyroSensor == null) gyroSensor = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE);

        accelSensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        magSensor = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
    }

    private void startSensorListeners() {
        if (sensorManager == null) return;
        sensorThread = new HandlerThread("AirMouseCalibrationSensorThread");
        sensorThread.start();
        sensorHandler = new Handler(sensorThread.getLooper());

        if (gyroSensor != null) sensorManager.registerListener(this, gyroSensor, SensorManager.SENSOR_DELAY_GAME, sensorHandler);
        if (accelSensor != null) sensorManager.registerListener(this, accelSensor, SensorManager.SENSOR_DELAY_GAME, sensorHandler);
        if (magSensor != null) sensorManager.registerListener(this, magSensor, SensorManager.SENSOR_DELAY_GAME, sensorHandler);
    }

    private void stopSensorListeners() {
        if (sensorManager != null) sensorManager.unregisterListener(this);
        if (sensorThread != null) {
            sensorThread.quitSafely();
            sensorThread = null;
            sensorHandler = null;
        }
    }

    private void setupButtons() {
        binding.btnStartGyroCal.setOnClickListener(v -> startGyroCalibration());

        binding.btnCaptureXPlus.setOnClickListener(v -> startAccelPoseCapture(0, "+X"));
        binding.btnCaptureXMinus.setOnClickListener(v -> startAccelPoseCapture(1, "-X"));
        binding.btnCaptureYPlus.setOnClickListener(v -> startAccelPoseCapture(2, "+Y"));
        binding.btnCaptureYMinus.setOnClickListener(v -> startAccelPoseCapture(3, "-Y"));
        binding.btnCaptureZPlus.setOnClickListener(v -> startAccelPoseCapture(4, "+Z"));
        binding.btnCaptureZMinus.setOnClickListener(v -> startAccelPoseCapture(5, "-Z"));
        binding.btnFinishAccelCal.setOnClickListener(v -> finishAccelCalibration());

        binding.btnStartMagCal.setOnClickListener(v -> startMagCalibration());
        binding.btnStopMagCal.setOnClickListener(v -> finishMagCalibration());

        binding.btnResetCalibration.setOnClickListener(v -> {
            calibration.reset();
            calibration.save(requireContext());
            for (int i = 0; i < accelPoseReady.length; i++) accelPoseReady[i] = false;
            updateStatus("Calibration reset and saved.");
            updateSummary();
        });
    }

    private void startGyroCalibration() {
        if (gyroSensor == null) {
            updateStatus("Gyroscope was not found on this phone.");
            return;
        }

        gyroSum[0] = gyroSum[1] = gyroSum[2] = 0f;
        gyroCount = 0;
        collectingGyro = true;
        updateStatus("Keep the phone completely still. Collecting gyro samples for 2 seconds...");

        binding.getRoot().postDelayed(() -> {
            collectingGyro = false;
            if (gyroCount < 20) {
                updateStatus("Gyro calibration failed. Not enough samples.");
                return;
            }
            calibration.gyroBias[0] = gyroSum[0] / gyroCount;
            calibration.gyroBias[1] = gyroSum[1] / gyroCount;
            calibration.gyroBias[2] = gyroSum[2] / gyroCount;
            calibration.save(requireContext());
            updateStatus("Gyro calibration saved. Samples: " + gyroCount);
            updateSummary();
        }, 2000);
    }

    private void startAccelPoseCapture(int index, String label) {
        if (accelSensor == null) {
            updateStatus("Accelerometer was not found.");
            return;
        }

        accelCaptureIndex = index;
        accelCaptureSum[0] = accelCaptureSum[1] = accelCaptureSum[2] = 0f;
        accelCaptureCount = 0;
        updateStatus("Hold phone in pose " + label + " and keep it still. Capturing for 0.8 seconds...");

        binding.getRoot().postDelayed(this::finishCurrentAccelPoseCapture, 800);
    }

    private void finishCurrentAccelPoseCapture() {
        int index = accelCaptureIndex;
        if (index < 0) return;
        accelCaptureIndex = -1;

        if (accelCaptureCount < 5) {
            updateStatus("Pose capture failed. Try again and keep the phone still.");
            return;
        }

        accelPoseSamples[index][0] = accelCaptureSum[0] / accelCaptureCount;
        accelPoseSamples[index][1] = accelCaptureSum[1] / accelCaptureCount;
        accelPoseSamples[index][2] = accelCaptureSum[2] / accelCaptureCount;
        accelPoseReady[index] = true;

        updateStatus(String.format(Locale.US,
                "Pose %s saved: [%.2f, %.2f, %.2f]",
                poseName(index), accelPoseSamples[index][0], accelPoseSamples[index][1], accelPoseSamples[index][2]));
        updateSummary();
    }

    private void finishAccelCalibration() {
        for (boolean ready : accelPoseReady) {
            if (!ready) {
                updateStatus("Please capture all 6 accelerometer poses first.");
                return;
            }
        }

        calibration.computeAccelCalibration(
                accelPoseSamples[0][0], accelPoseSamples[1][0],
                accelPoseSamples[2][1], accelPoseSamples[3][1],
                accelPoseSamples[4][2], accelPoseSamples[5][2]
        );
        calibration.save(requireContext());
        updateStatus("Accelerometer 6-position calibration saved.");
        updateSummary();
    }

    private void startMagCalibration() {
        if (magSensor == null) {
            updateStatus("Magnetometer was not found.");
            return;
        }

        magMin[0] = magMin[1] = magMin[2] = Float.POSITIVE_INFINITY;
        magMax[0] = magMax[1] = magMax[2] = Float.NEGATIVE_INFINITY;
        magCount = 0;
        collectingMag = true;
        updateStatus("Move the phone slowly in a figure-8 shape. Then press Stop Magnetometer Calibration.");
    }

    private void finishMagCalibration() {
        collectingMag = false;
        if (magCount < 30) {
            updateStatus("Magnetometer calibration failed. Move phone in figure-8 longer and try again.");
            return;
        }

        calibration.computeMagCalibration(magMin[0], magMax[0], magMin[1], magMax[1], magMin[2], magMax[2]);
        calibration.save(requireContext());
        updateStatus("Magnetometer figure-8 calibration saved. Samples: " + magCount);
        updateSummary();
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        int type = event.sensor.getType();

        if (type == Sensor.TYPE_GYROSCOPE || type == Sensor.TYPE_GYROSCOPE_UNCALIBRATED) {
            System.arraycopy(event.values, 0, currentGyro, 0, 3);
            if (collectingGyro) {
                gyroSum[0] += currentGyro[0];
                gyroSum[1] += currentGyro[1];
                gyroSum[2] += currentGyro[2];
                gyroCount++;
            }
        } else if (type == Sensor.TYPE_ACCELEROMETER) {
            System.arraycopy(event.values, 0, currentAccel, 0, 3);
            if (accelCaptureIndex >= 0) {
                accelCaptureSum[0] += currentAccel[0];
                accelCaptureSum[1] += currentAccel[1];
                accelCaptureSum[2] += currentAccel[2];
                accelCaptureCount++;
            }
        } else if (type == Sensor.TYPE_MAGNETIC_FIELD) {
            System.arraycopy(event.values, 0, currentMag, 0, 3);
            if (collectingMag) {
                for (int i = 0; i < 3; i++) {
                    magMin[i] = Math.min(magMin[i], currentMag[i]);
                    magMax[i] = Math.max(magMax[i], currentMag[i]);
                }
                magCount++;
            }
        }

        updateLiveValuesThrottled();
    }

    private long lastLiveUiNs = 0L;
    private void updateLiveValuesThrottled() {
        long now = System.nanoTime();
        if (now - lastLiveUiNs < 150_000_000L) return;
        lastLiveUiNs = now;
        runOnUiSafe(() -> binding.txtLiveValues.setText(String.format(Locale.US,
                "Live raw values\nGyro: [%.3f, %.3f, %.3f]\nAccel: [%.2f, %.2f, %.2f]\nMag: [%.2f, %.2f, %.2f]",
                currentGyro[0], currentGyro[1], currentGyro[2],
                currentAccel[0], currentAccel[1], currentAccel[2],
                currentMag[0], currentMag[1], currentMag[2])));
    }

    private void updateSummary() {
        runOnUiSafe(() -> binding.txtCalibrationSummary.setText(calibration.summary() + "\n\nAccelerometer poses: " + poseProgressText()));
    }

    private void updateStatus(String text) {
        runOnUiSafe(() -> binding.txtCalibrationStatus.setText(text));
    }

    private String poseProgressText() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < accelPoseReady.length; i++) {
            if (i > 0) sb.append(" | ");
            sb.append(poseName(i)).append(": ").append(accelPoseReady[i] ? "OK" : "missing");
        }
        return sb.toString();
    }

    private String poseName(int index) {
        switch (index) {
            case 0: return "+X";
            case 1: return "-X";
            case 2: return "+Y";
            case 3: return "-Y";
            case 4: return "+Z";
            case 5: return "-Z";
            default: return "?";
        }
    }

    private void runOnUiSafe(Runnable runnable) {
        FragmentCalibrationBinding current = binding;
        if (current == null) return;
        current.getRoot().post(() -> {
            if (binding != null) runnable.run();
        });
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
    }

    @Override
    public void onDestroyView() {
        stopSensorListeners();
        super.onDestroyView();
        binding = null;
    }
}
