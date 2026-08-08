# Air Mouse Integrated Version

## Run laptop server

```bash
cd laptop
pip install pyautogui -i https://pypi.devneeds.ir/simple/
python laptop_air_mouse_server.py --port 5002
```

Copy the printed laptop IP into the Android app and set the same port.

## Android flow

1. Open Sensor Calibration.
2. Calibrate gyro while the phone is still.
3. Capture the six accelerometer poses.
4. Move the phone in figure-8 and stop magnetometer calibration.
5. Open Controller.
6. Enter laptop IP and port.
7. Press Start.

## Perfetto

The app defines trace sections with names beginning with `airmouse_`.
Use `perfetto/config.pbtx` for recording, then run:

```bash
python perfetto/analyze_trace.py
```

Fill the measured numbers in `report/answers_template.md`.
