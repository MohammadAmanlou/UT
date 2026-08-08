package com.example.airmouse;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.Locale;

public class SensorCalibration {

    private static final String PREFS = "air_mouse_sensor_calibration";
    private static final float G = 9.81f;

    public final float[] gyroBias = new float[]{0f, 0f, 0f};
    public final float[] accelOffset = new float[]{0f, 0f, 0f};
    public final float[] accelScale = new float[]{1f, 1f, 1f};
    public final float[] magOffset = new float[]{0f, 0f, 0f};
    public final float[] magScale = new float[]{1f, 1f, 1f};

    public void reset() {
        gyroBias[0] = gyroBias[1] = gyroBias[2] = 0f;
        accelOffset[0] = accelOffset[1] = accelOffset[2] = 0f;
        accelScale[0] = accelScale[1] = accelScale[2] = 1f;
        magOffset[0] = magOffset[1] = magOffset[2] = 0f;
        magScale[0] = magScale[1] = magScale[2] = 1f;
    }

    public float correctGyroX(float x) { return x - gyroBias[0]; }
    public float correctGyroY(float y) { return y - gyroBias[1]; }
    public float correctGyroZ(float z) { return z - gyroBias[2]; }

    public float correctAccelX(float x) { return (x - accelOffset[0]) * accelScale[0]; }
    public float correctAccelY(float y) { return (y - accelOffset[1]) * accelScale[1]; }
    public float correctAccelZ(float z) { return (z - accelOffset[2]) * accelScale[2]; }

    public float correctMagX(float x) { return (x - magOffset[0]) / safeScale(magScale[0]); }
    public float correctMagY(float y) { return (y - magOffset[1]) / safeScale(magScale[1]); }
    public float correctMagZ(float z) { return (z - magOffset[2]) / safeScale(magScale[2]); }

    public float[] correctAccel(float x, float y, float z) {
        return new float[]{correctAccelX(x), correctAccelY(y), correctAccelZ(z)};
    }

    public float[] correctMag(float x, float y, float z) {
        return new float[]{correctMagX(x), correctMagY(y), correctMagZ(z)};
    }

    public void computeAccelCalibration(float xPlus, float xMinus,
                                        float yPlus, float yMinus,
                                        float zPlus, float zMinus) {
        accelOffset[0] = (xPlus + xMinus) / 2f;
        accelOffset[1] = (yPlus + yMinus) / 2f;
        accelOffset[2] = (zPlus + zMinus) / 2f;

        accelScale[0] = safeScale((2f * G) / (xPlus - xMinus));
        accelScale[1] = safeScale((2f * G) / (yPlus - yMinus));
        accelScale[2] = safeScale((2f * G) / (zPlus - zMinus));
    }

    public void computeMagCalibration(float minX, float maxX,
                                      float minY, float maxY,
                                      float minZ, float maxZ) {
        magOffset[0] = (maxX + minX) / 2f;
        magOffset[1] = (maxY + minY) / 2f;
        magOffset[2] = (maxZ + minZ) / 2f;

        magScale[0] = Math.max(0.0001f, Math.abs(maxX - minX) / 2f);
        magScale[1] = Math.max(0.0001f, Math.abs(maxY - minY) / 2f);
        magScale[2] = Math.max(0.0001f, Math.abs(maxZ - minZ) / 2f);
    }

    public static SensorCalibration load(Context context) {
        SensorCalibration c = new SensorCalibration();
        SharedPreferences sp = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
        for (int i = 0; i < 3; i++) {
            c.gyroBias[i] = sp.getFloat("gyroBias" + i, 0f);
            c.accelOffset[i] = sp.getFloat("accelOffset" + i, 0f);
            c.accelScale[i] = sp.getFloat("accelScale" + i, 1f);
            c.magOffset[i] = sp.getFloat("magOffset" + i, 0f);
            c.magScale[i] = sp.getFloat("magScale" + i, 1f);
        }
        return c;
    }

    public void save(Context context) {
        SharedPreferences.Editor e = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit();
        for (int i = 0; i < 3; i++) {
            e.putFloat("gyroBias" + i, gyroBias[i]);
            e.putFloat("accelOffset" + i, accelOffset[i]);
            e.putFloat("accelScale" + i, accelScale[i]);
            e.putFloat("magOffset" + i, magOffset[i]);
            e.putFloat("magScale" + i, magScale[i]);
        }
        e.apply();
    }

    public String summary() {
        return String.format(Locale.US,
                "Gyro bias: [%.5f, %.5f, %.5f]\n" +
                "Accel offset: [%.3f, %.3f, %.3f]\n" +
                "Accel scale: [%.3f, %.3f, %.3f]\n" +
                "Mag offset: [%.3f, %.3f, %.3f]\n" +
                "Mag scale: [%.3f, %.3f, %.3f]",
                gyroBias[0], gyroBias[1], gyroBias[2],
                accelOffset[0], accelOffset[1], accelOffset[2],
                accelScale[0], accelScale[1], accelScale[2],
                magOffset[0], magOffset[1], magOffset[2],
                magScale[0], magScale[1], magScale[2]);
    }

    private static float safeScale(float value) {
        if (Float.isNaN(value) || Float.isInfinite(value) || Math.abs(value) < 0.0001f) {
            return 1f;
        }
        return value;
    }
}
