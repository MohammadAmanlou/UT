package com.example.airmouse;

import android.os.Trace;

import java.util.Locale;

public class AirMouseMapper {

    public static class MouseOutput {
        public final int dx;
        public final int dy;
        public final boolean click;

        public MouseOutput(int dx, int dy, boolean click) {
            this.dx = dx;
            this.dy = dy;
            this.click = click;
        }

        public boolean hasMove() {
            return dx != 0 || dy != 0;
        }
    }

    private float sensitivity = 18f;

    private SensorCalibration calibration = new SensorCalibration();
    private final ComplementaryFilter complementaryFilter = new ComplementaryFilter();

    private final float[] calibrationSum = new float[]{0f, 0f, 0f};
    private int calibrationCount = 0;

    private long lastMoveNs = 0L;
    private long lastClickNs = 0L;
    private long lastScrollNs = 0L;

    private float filteredHorizontal = 0f;
    private float filteredVertical = 0f;

    private final float[] gravity = new float[]{0f, 0f, 0f};
    private final float[] lastCorrectedAccel = new float[]{0f, 0f, 0f};
    private final float[] lastCorrectedMag = new float[]{0f, 0f, 0f};

    private static final float GYRO_DEAD_ZONE = 0.045f;
    private static final float SMOOTH_ALPHA = 0.72f;
    private static final long MOVE_PERIOD_NS = 16_000_000L;

    private static final float CLICK_THRESHOLD = -3.0f;
    private static final long CLICK_COOLDOWN_NS = 450_000_000L;

    // Scroll detection parameters.
    // Reliable version: uses a simple high-pass acceleration on Y.
    // It is intentionally easier to trigger than the previous state machine,
    // but each detected scroll is locked for a short time to avoid +3/-3 rebound.
    private static final float SCROLL_THRESHOLD = 2.2f;
    private static final long SCROLL_LOCK_NS = 1_100_000_000L;
    private static final long ACCEL_WARMUP_NS = 350_000_000L;
    private static final float GRAVITY_ALPHA = 0.94f;
    private static final float LINEAR_ALPHA = 0.25f;

    private boolean gravityInitialized = false;
    private long accelStartNs = 0L;
    private long scrollLockedUntilNs = 0L;
    private float filteredLinearX = 0f;
    private float filteredLinearY = 0f;
    private float filteredLinearZ = 0f;

    private float lastGyroMagnitude = 0f;
    private long lastGyroUpdateNs = 0L;

    public void setCalibration(SensorCalibration calibration) {
        if (calibration != null) {
            this.calibration = calibration;
        }
    }

    public SensorCalibration getCalibration() {
        return calibration;
    }

    public void setSensitivity(int seekBarValue) {
        this.sensitivity = 8f + seekBarValue * 0.35f;
    }

    public void beginGyroCalibration() {
        calibrationSum[0] = 0f;
        calibrationSum[1] = 0f;
        calibrationSum[2] = 0f;
        calibrationCount = 0;
    }

    public void addGyroCalibrationSample(float gx, float gy, float gz) {
        calibrationSum[0] += gx;
        calibrationSum[1] += gy;
        calibrationSum[2] += gz;
        calibrationCount++;
    }

    public boolean finishGyroCalibration() {
        if (calibrationCount < 20) return false;

        calibration.gyroBias[0] = calibrationSum[0] / calibrationCount;
        calibration.gyroBias[1] = calibrationSum[1] / calibrationCount;
        calibration.gyroBias[2] = calibrationSum[2] / calibrationCount;

        return true;
    }

    public void resetRuntime() {
        lastMoveNs = 0L;
        lastClickNs = 0L;
        lastScrollNs = 0L;
        filteredHorizontal = 0f;
        filteredVertical = 0f;
        gravity[0] = 0f;
        gravity[1] = 0f;
        gravity[2] = 0f;
        gravityInitialized = false;
        accelStartNs = 0L;
        scrollLockedUntilNs = 0L;
        filteredLinearX = 0f;
        filteredLinearY = 0f;
        filteredLinearZ = 0f;
        lastGyroMagnitude = 0f;
        lastGyroUpdateNs = 0L;
        lastCorrectedAccel[0] = lastCorrectedAccel[1] = lastCorrectedAccel[2] = 0f;
        lastCorrectedMag[0] = lastCorrectedMag[1] = lastCorrectedMag[2] = 0f;
        complementaryFilter.reset();
    }

    public MouseOutput onGyro(long timestampNs, float rawGx, float rawGy, float rawGz) {
        Trace.beginSection("airmouse_filter_gyro");
        try {
            float gx = calibration.correctGyroX(rawGx);
            float gy = calibration.correctGyroY(rawGy);
            float gz = calibration.correctGyroZ(rawGz);

            lastGyroMagnitude = Math.abs(gx) + Math.abs(gy) + Math.abs(gz);
            lastGyroUpdateNs = timestampNs;

            complementaryFilter.updateGyro(timestampNs, gx, gy, gz);

            int dx = 0;
            int dy = 0;

            float horizontalRate = Math.abs(gz) < GYRO_DEAD_ZONE ? 0f : gz;
            float verticalRate = Math.abs(gx) < GYRO_DEAD_ZONE ? 0f : gx;

            filteredHorizontal = SMOOTH_ALPHA * filteredHorizontal + (1f - SMOOTH_ALPHA) * horizontalRate;
            filteredVertical = SMOOTH_ALPHA * filteredVertical + (1f - SMOOTH_ALPHA) * verticalRate;

            if (timestampNs - lastMoveNs >= MOVE_PERIOD_NS) {
                lastMoveNs = timestampNs;

                dx = clamp(Math.round(filteredHorizontal * sensitivity), -45, 45);
                dy = clamp(Math.round(-filteredVertical * sensitivity), -45, 45);

                if (Math.abs(dx) <= 1) dx = 0;
                if (Math.abs(dy) <= 1) dy = 0;
            }

            boolean click = false;
            boolean yIsDominant = Math.abs(gy) > Math.abs(gx) * 1.15f && Math.abs(gy) > Math.abs(gz) * 1.15f;

            if (gy < CLICK_THRESHOLD && yIsDominant && timestampNs - lastClickNs > CLICK_COOLDOWN_NS) {
                click = true;
                lastClickNs = timestampNs;
            }

            return new MouseOutput(dx, dy, click);
        } finally {
            Trace.endSection();
        }
    }

    public int onAccelerometer(long timestampNs, float rawAx, float rawAy, float rawAz) {
        Trace.beginSection("airmouse_filter_accel");
        try {
            float ax = calibration.correctAccelX(rawAx);
            float ay = calibration.correctAccelY(rawAy);
            float az = calibration.correctAccelZ(rawAz);

            lastCorrectedAccel[0] = ax;
            lastCorrectedAccel[1] = ay;
            lastCorrectedAccel[2] = az;

            complementaryFilter.updateAccel(ax, ay, az);

            if (!gravityInitialized) {
                gravity[0] = ax;
                gravity[1] = ay;
                gravity[2] = az;
                accelStartNs = timestampNs;
                gravityInitialized = true;
                return 0;
            }

            gravity[0] = GRAVITY_ALPHA * gravity[0] + (1f - GRAVITY_ALPHA) * ax;
            gravity[1] = GRAVITY_ALPHA * gravity[1] + (1f - GRAVITY_ALPHA) * ay;
            gravity[2] = GRAVITY_ALPHA * gravity[2] + (1f - GRAVITY_ALPHA) * az;

            float linearX = ax - gravity[0];
            float linearY = ay - gravity[1];
            float linearZ = az - gravity[2];

            filteredLinearX = LINEAR_ALPHA * filteredLinearX + (1f - LINEAR_ALPHA) * linearX;
            filteredLinearY = LINEAR_ALPHA * filteredLinearY + (1f - LINEAR_ALPHA) * linearY;
            filteredLinearZ = LINEAR_ALPHA * filteredLinearZ + (1f - LINEAR_ALPHA) * linearZ;

            if (timestampNs - accelStartNs < ACCEL_WARMUP_NS) {
                return 0;
            }

            if (timestampNs < scrollLockedUntilNs) {
                return 0;
            }

            float absY = Math.abs(filteredLinearY);

            if (absY >= SCROLL_THRESHOLD) {
                scrollLockedUntilNs = timestampNs + SCROLL_LOCK_NS;
                lastScrollNs = timestampNs;
                return filteredLinearY > 0f ? 20 : -20;
            }

            return 0;
        } finally {
            Trace.endSection();
        }
    }

    public float[] onMagnetometer(float rawMx, float rawMy, float rawMz) {
        Trace.beginSection("airmouse_filter_mag");
        try {
            lastCorrectedMag[0] = calibration.correctMagX(rawMx);
            lastCorrectedMag[1] = calibration.correctMagY(rawMy);
            lastCorrectedMag[2] = calibration.correctMagZ(rawMz);
            return new float[]{lastCorrectedMag[0], lastCorrectedMag[1], lastCorrectedMag[2]};
        } finally {
            Trace.endSection();
        }
    }

    public String biasText() {
        return String.format(Locale.US,
                "Gyro Bias: x=%.5f y=%.5f z=%.5f",
                calibration.gyroBias[0], calibration.gyroBias[1], calibration.gyroBias[2]);
    }

    public String filterText() {
        return String.format(Locale.US,
                "roll=%.3f pitch=%.3f yaw=%.3f",
                complementaryFilter.getRoll(), complementaryFilter.getPitch(), complementaryFilter.getYaw());
    }

    public float correctedGyroX(float x) { return calibration.correctGyroX(x); }
    public float correctedGyroY(float y) { return calibration.correctGyroY(y); }
    public float correctedGyroZ(float z) { return calibration.correctGyroZ(z); }

    public float correctedAccelX(float x) { return calibration.correctAccelX(x); }
    public float correctedAccelY(float y) { return calibration.correctAccelY(y); }
    public float correctedAccelZ(float z) { return calibration.correctAccelZ(z); }

    private int clamp(int value, int low, int high) {
        return Math.max(low, Math.min(high, value));
    }
}
