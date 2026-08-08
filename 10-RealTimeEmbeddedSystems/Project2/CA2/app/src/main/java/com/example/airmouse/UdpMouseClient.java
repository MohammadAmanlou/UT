package com.example.airmouse;

import android.os.Trace;

import org.json.JSONObject;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class UdpMouseClient {

    private final InetAddress address;
    private final int port;
    private final DatagramSocket socket;
    private final ExecutorService executor;
    private final AtomicInteger seqCounter = new AtomicInteger(1);
    private final AtomicBoolean moveBusy = new AtomicBoolean(false);

    private volatile boolean active = true;

    public UdpMouseClient(String host, int port) throws Exception {
        this.address = InetAddress.getByName(host);
        this.port = port;
        this.socket = new DatagramSocket();
        this.socket.setSoTimeout(80);
        this.executor = Executors.newSingleThreadExecutor(r -> new Thread(r, "AirMouseUdpThread"));
    }

    public void close() {
        active = false;
        try {
            socket.close();
        } catch (Exception ignored) {
        }
        executor.shutdownNow();
    }

    public void sendMove(int dx, int dy) {
        if (!active) return;
        if (dx == 0 && dy == 0) return;

        // Move packets are intentionally droppable. This prevents old movement packets from building up.
        if (!moveBusy.compareAndSet(false, true)) return;

        executor.execute(() -> {
            Trace.beginSection("airmouse_udp_move_task");
            try {
                if (!active) return;

                JSONObject json = new JSONObject();
                json.put("type", "move");
                json.put("dx", dx);
                json.put("dy", dy);
                json.put("DeltaX", dx);
                json.put("DeltaY", dy);
                json.put("click", false);
                json.put("Click", false);
                json.put("scroll", 0);
                json.put("Scroll", 0);
                json.put("t", System.currentTimeMillis());

                sendJson(json);
            } catch (Exception ignored) {
            } finally {
                moveBusy.set(false);
                Trace.endSection();
            }
        });
    }

    public void sendEvent(boolean click, int scroll) {
        if (!active) return;
        if (!click && scroll == 0) return;

        int seq = seqCounter.getAndIncrement();

        executor.execute(() -> {
            Trace.beginSection("airmouse_udp_event_task");
            try {
                if (!active) return;

                JSONObject json = new JSONObject();
                json.put("type", "event");
                json.put("seq", seq);
                json.put("dx", 0);
                json.put("dy", 0);
                json.put("DeltaX", 0);
                json.put("DeltaY", 0);
                json.put("click", click);
                json.put("Click", click);
                json.put("scroll", scroll);
                json.put("Scroll", scroll);
                json.put("t", System.currentTimeMillis());

                for (int i = 0; i < 5 && active; i++) {
                    sendJson(json);
                    if (waitAck(seq)) return;
                }
            } catch (Exception ignored) {
            } finally {
                Trace.endSection();
            }
        });
    }

    private void sendJson(JSONObject json) throws Exception {
        Trace.beginSection("airmouse_udp_send");
        try {
            byte[] data = json.toString().getBytes(StandardCharsets.UTF_8);
            DatagramPacket packet = new DatagramPacket(data, data.length, address, port);
            socket.send(packet);
        } finally {
            Trace.endSection();
        }
    }

    private boolean waitAck(int seq) {
        Trace.beginSection("airmouse_udp_wait_ack");
        try {
            byte[] buffer = new byte[256];
            DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
            socket.receive(packet);
            String text = new String(packet.getData(), 0, packet.getLength(), StandardCharsets.UTF_8);
            JSONObject ack = new JSONObject(text);
            return ack.optInt("ack", -1) == seq;
        } catch (Exception e) {
            return false;
        } finally {
            Trace.endSection();
        }
    }
}
