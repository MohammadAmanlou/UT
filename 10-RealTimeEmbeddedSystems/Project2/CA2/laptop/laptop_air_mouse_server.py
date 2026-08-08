import argparse
import json
import socket
import time
from collections import OrderedDict

import pyautogui
import pprint


def clamp(value, low, high):
    return max(low, min(high, value))


def get_laptop_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return socket.gethostbyname(socket.gethostname())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", type=int, default=5000)
    parser.add_argument("--scale", type=float, default=1.0)
    parser.add_argument("--max-step", type=int, default=60)
    parser.add_argument("--scroll-unit", type=int, default=5)
    args = parser.parse_args()

    pyautogui.FAILSAFE = True
    pyautogui.PAUSE = 0

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(("0.0.0.0", args.port))
    sock.settimeout(0.2)

    seen_events = OrderedDict()

    print("Air Mouse UDP Server is running")
    print(f"Laptop IP: {get_laptop_ip()}")
    print(f"Listening on UDP port {args.port}")
    print("Enter this IP and port in the Android app.")
    print("Press Ctrl+C to stop.\n")

    def is_duplicate(addr, seq):
        key = (addr[0], addr[1], seq)
        if key in seen_events:
            return True
        seen_events[key] = time.time()
        while len(seen_events) > 300:
            seen_events.popitem(last=False)
        return False

    def send_ack(addr, seq):
        ack_packet = json.dumps({"ack": seq}).encode("utf-8")
        sock.sendto(ack_packet, addr)

    try:
        while True:
            try:
                data, addr = sock.recvfrom(2048)
            except socket.timeout:
                continue

            try:
                packet = json.loads(data.decode("utf-8"))
            except Exception:
                continue

            packet_type = packet.get("type", "move")
            seq = packet.get("seq", None)

            dx = float(packet.get("dx", packet.get("DeltaX", 0)))
            dy = float(packet.get("dy", packet.get("DeltaY", 0)))
            click = bool(packet.get("click", packet.get("Click", False)))
            scroll = int(packet.get("scroll", packet.get("Scroll", 0)))
            # pprint.pprint(packet)

            is_event = packet_type == "event" or click or scroll != 0

            if is_event:
                duplicate = False
                if seq is not None:
                    duplicate = is_duplicate(addr, int(seq))

                if not duplicate:
                    if click:
                        pyautogui.click()
                        print("CLICK")
                    if scroll != 0:
                        pyautogui.scroll(scroll * args.scroll_unit)
                        print("SCROLL:", scroll)

                if seq is not None:
                    send_ack(addr, int(seq))

            else:
                move_x = int(round(-dx * args.scale))
                move_y = int(round(dy * args.scale))
                move_x = clamp(move_x, -args.max_step, args.max_step)
                move_y = clamp(move_y, -args.max_step, args.max_step)

                if move_x != 0 or move_y != 0:
                    pyautogui.moveRel(move_x, move_y, duration=0)

    except KeyboardInterrupt:
        print("\nServer stopped.")
    except pyautogui.FailSafeException:
        print("\nStopped by PyAutoGUI fail-safe. Mouse moved to screen corner.")
    finally:
        sock.close()


if __name__ == "__main__":
    main()
