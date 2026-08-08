from perfetto.trace_processor import TraceProcessor

TRACE_FILE = "trace_file.perfetto-trace"

tp = TraceProcessor(
    trace=TRACE_FILE,
    addr="http://127.0.0.1:9001"
)

def run_query(title, sql):
    print("\n" + "=" * 90)
    print(title)
    print("=" * 90)
    try:
        result = tp.query(sql)
        rows = list(result)
        if not rows:
            print("NO ROWS")
        for row in rows:
            print(row)
    except Exception as e:
        print("ERROR:", e)

run_query(
    "1) Custom AirMouse trace sections",
    """
    select
        name,
        count(*) as count,
        avg(dur) / 1000000.0 as avg_ms,
        max(dur) / 1000000.0 as max_ms
    from slice
    where name like 'airmouse_%'
    group by name
    order by avg_ms desc;
    """
)

run_query(
    "2) Sensor event interval for Gyroscope",
    """
    with s as (
        select
            ts,
            lead(ts) over (order by ts) as next_ts
        from slice
        where name = 'airmouse_sensor_gyro'
    )
    select
        count(*) as samples,
        avg(next_ts - ts) / 1000000.0 as avg_interval_ms,
        min(next_ts - ts) / 1000000.0 as min_interval_ms,
        max(next_ts - ts) / 1000000.0 as max_interval_ms
    from s
    where next_ts is not null;
    """
)

run_query(
    "3) Sensor event interval for Accelerometer",
    """
    with s as (
        select
            ts,
            lead(ts) over (order by ts) as next_ts
        from slice
        where name = 'airmouse_sensor_accel'
    )
    select
        count(*) as samples,
        avg(next_ts - ts) / 1000000.0 as avg_interval_ms,
        min(next_ts - ts) / 1000000.0 as min_interval_ms,
        max(next_ts - ts) / 1000000.0 as max_interval_ms
    from s
    where next_ts is not null;
    """
)

run_query(
    "4) Sensor event interval for Magnetometer",
    """
    with s as (
        select
            ts,
            lead(ts) over (order by ts) as next_ts
        from slice
        where name = 'airmouse_sensor_mag'
    )
    select
        count(*) as samples,
        avg(next_ts - ts) / 1000000.0 as avg_interval_ms,
        min(next_ts - ts) / 1000000.0 as min_interval_ms,
        max(next_ts - ts) / 1000000.0 as max_interval_ms
    from s
    where next_ts is not null;
    """
)

run_query(
    "5) Filter execution time",
    """
    select
        name,
        count(*) as count,
        avg(dur) / 1000000.0 as avg_ms,
        min(dur) / 1000000.0 as min_ms,
        max(dur) / 1000000.0 as max_ms
    from slice
    where name in ('airmouse_filter_gyro', 'airmouse_filter_accel')
    group by name
    order by avg_ms desc;
    """
)

run_query(
    "6) UDP send and ACK wait time",
    """
    select
        name,
        count(*) as count,
        avg(dur) / 1000000.0 as avg_ms,
        min(dur) / 1000000.0 as min_ms,
        max(dur) / 1000000.0 as max_ms
    from slice
    where name in ('airmouse_udp_send', 'airmouse_udp_wait_ack')
    group by name
    order by avg_ms desc;
    """
)

run_query(
    "7) Thread activity for AirMouse sections",
    """
    select
        thread.name as thread_name,
        slice.name as section_name,
        count(*) as count,
        avg(slice.dur) / 1000000.0 as avg_ms,
        max(slice.dur) / 1000000.0 as max_ms
    from slice
    join thread_track on slice.track_id = thread_track.id
    join thread using(utid)
    where slice.name like 'airmouse_%'
    group by thread.name, slice.name
    order by thread.name, section_name;
    """
)

run_query(
    "8) Most active threads by CPU scheduling time",
    """
    select
        thread.name as thread_name,
        count(*) as sched_count,
        sum(dur) / 1000000.0 as total_ms,
        avg(dur) / 1000000.0 as avg_ms
    from sched
    join thread using(utid)
    where thread.name is not null
    group by thread.name
    order by total_ms desc
    limit 30;
    """
)

run_query(
    "9) CPU frequency summary",
    """
    select
        cpu,
        count(*) as samples,
        min(value) as min_freq,
        avg(value) as avg_freq,
        max(value) as max_freq
    from counter
    join cpu_counter_track on counter.track_id = cpu_counter_track.id
    where cpu_counter_track.name = 'cpufreq'
    group by cpu
    order by cpu;
    """
)

run_query(
    "10) Approximate latency from sensor event to UDP send",
    """
    with sensor as (
        select ts
        from slice
        where name in ('airmouse_sensor_gyro', 'airmouse_sensor_accel')
    ),
    udp as (
        select ts
        from slice
        where name = 'airmouse_udp_send'
    ),
    pairs as (
        select
            sensor.ts as sensor_ts,
            (
                select min(udp.ts - sensor.ts)
                from udp
                where udp.ts >= sensor.ts
                  and udp.ts - sensor.ts < 50000000
            ) as latency_ns
        from sensor
    )
    select
        count(*) as matched_events,
        avg(latency_ns) / 1000000.0 as avg_latency_ms,
        min(latency_ns) / 1000000.0 as min_latency_ms,
        max(latency_ns) / 1000000.0 as max_latency_ms
    from pairs
    where latency_ns is not null;
    """
)

tp.close()