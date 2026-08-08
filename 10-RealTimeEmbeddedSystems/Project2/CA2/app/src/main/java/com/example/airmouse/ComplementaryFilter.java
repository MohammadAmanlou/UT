package com.example.airmouse;

public class ComplementaryFilter {

    private static final float ALPHA = 0.96f;

    private boolean gyroInitialized = false;
    private long lastGyroTimestampNs = 0L;

    private float roll = 0f;
    private float pitch = 0f;
    private float yaw = 0f;

    public void reset() {
        gyroInitialized = false;
        lastGyroTimestampNs = 0L;
        roll = 0f;
        pitch = 0f;
        yaw = 0f;
    }

    public void updateGyro(long timestampNs, float gx, float gy, float gz) {
        if (!gyroInitialized) {
            gyroInitialized = true;
            lastGyroTimestampNs = timestampNs;
            return;
        }

        float dt = (timestampNs - lastGyroTimestampNs) / 1_000_000_000f;
        lastGyroTimestampNs = timestampNs;

        if (dt <= 0f || dt > 0.2f) return;

        roll += gx * dt;
        pitch += gy * dt;
        yaw += gz * dt;
    }

    public void updateAccel(float ax, float ay, float az) {
        float accelRoll = (float) Math.atan2(ay, az);
        float accelPitch = (float) Math.atan2(-ax, Math.sqrt(ay * ay + az * az));

        roll = ALPHA * roll + (1f - ALPHA) * accelRoll;
        pitch = ALPHA * pitch + (1f - ALPHA) * accelPitch;
    }

    public float getRoll() { return roll; }
    public float getPitch() { return pitch; }
    public float getYaw() { return yaw; }
}
