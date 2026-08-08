import os
import shutil
import numpy as np

RUNS = 5
SIM_TIME = 50.0

SCENARIOS = {
    "tcp_only": {
        "tcl": "tcp_only.tcl",
        "trace": "tcp_only.tr"
    },
    "udp_raw": {
        "tcl": "tcp_udp_raw.tcl",
        "trace": "tcp_udp_raw.tr"
    },
    "udp_friendly": {
        "tcl": "tcp_udp_friendly.tcl",
        "trace": "tcp_udp_friendly.tr"
    }
}

BASE_RESULT_DIR = "results"

def parse_trace(filename):
    recv_bytes = {}
    send_times = {}
    delays = []

    is_tcp_only = "tcp_only" in filename

    if is_tcp_only:
        bottleneck_from = "1"
        bottleneck_to = "2"
    else:
        bottleneck_from = "2"
        bottleneck_to = "3"

    with open(filename, "r") as f:
        for line in f:
            p = line.split()
            if len(p) < 6:
                continue

            event = p[0]
            time = float(p[1])
            from_node = p[2]
            to_node = p[3]
            pkt_type = p[4].lower()
            pkt_size = int(p[5])

            if pkt_type not in ["tcp", "cbr"]:
                continue

            if is_tcp_only:
                flow_id = "tcp"
            elif pkt_type == "tcp":
                flow_id = "tcp"
            elif pkt_type == "cbr":
                flow_id = "udp"



            pkt_id = f"{p[11]}_{from_node}_{to_node}_{flow_id}" if len(p) > 11 else f"{flow_id}_{time}"
            if event == "+":
                send_times.setdefault(flow_id, {})[pkt_id] = time
            elif event == "r":
                if flow_id in send_times and pkt_id in send_times[flow_id]:
                    t_send = send_times[flow_id].pop(pkt_id)
                    delays.append(time - t_send)

            if from_node != bottleneck_from or to_node != bottleneck_to:
                continue

            if event == "r":
                recv_bytes[flow_id] = recv_bytes.get(flow_id, 0) + pkt_size

    dropped_packets = sum(len(times) for times in send_times.values())

    return recv_bytes, dropped_packets, delays

def jain_fairness(values):
    values = np.array(values)
    if len(values) <= 1:
        return 1.0
    if np.all(values == 0):
        return 0.0
    return (values.sum()**2) / (len(values) * np.sum(values**2))

def calc_throughput(bytes_recv):
    return (bytes_recv * 8) / SIM_TIME / 1e6

def run_one_epoch(scenario, run_id):
    tcl = SCENARIOS[scenario]["tcl"]
    trace = SCENARIOS[scenario]["trace"]

    print(f"  → Running {scenario}, run {run_id}")
    os.system(f"ns {tcl}")

    recv_bytes, total_dropped, delays = parse_trace(trace)

    throughputs = [calc_throughput(v) for v in recv_bytes.values()]
    avg_delay = np.mean(delays) if delays else 0.0
    fairness = jain_fairness(throughputs)

    scenario_dir = os.path.join(BASE_RESULT_DIR, scenario, str(run_id))
    os.makedirs(scenario_dir, exist_ok=True)
    shutil.move(trace, os.path.join(scenario_dir, trace))

    return {
        "throughput": throughputs,
        "loss": total_dropped,
        "delay": avg_delay,
        "fairness": fairness
    }

def run_all():
    if os.path.exists(BASE_RESULT_DIR):
        shutil.rmtree(BASE_RESULT_DIR)
    os.makedirs(BASE_RESULT_DIR)

    results = {s: [] for s in SCENARIOS}

    for i in range(1, RUNS + 1):
        print(f"\n=== RUN {i} ===")
        for scenario in SCENARIOS:
            metrics = run_one_epoch(scenario, i)
            results[scenario].append(metrics)

    print("\n================ FINAL AVERAGES ================\n")
    for scenario in results:
        avg_tp = np.mean([np.sum(r["throughput"]) for r in results[scenario]])
        avg_loss = np.mean([r["loss"] for r in results[scenario]])
        avg_delay = np.mean([r["delay"] for r in results[scenario]])
        avg_fairness = np.mean([r["fairness"] for r in results[scenario]])

        print(f"{scenario.upper()}")
        print(f"  Avg Throughput : {avg_tp:.3f} Mbps")
        print(f"  Avg Packet Loss: {avg_loss:.2f}")
        print(f"  Avg Delay      : {avg_delay*1000:.2f} ms")
        print(f"  Jain Fairness  : {avg_fairness:.3f}")
        print("-" * 45)

if __name__ == "__main__":
    run_all()