set ns [new Simulator]
set tf [open tcp_udp_friendly.tr w]
$ns trace-all $tf

set rate 1.0
set loss_flag 0

proc update_rate {} {
    global rate loss_flag cbr
    if {$loss_flag == 1} {
        set rate [expr $rate * 0.85]
        set loss_flag 0
    } else {
        set rate [expr $rate + 0.01*$rate]
    }
    $cbr set rate_ "${rate}Mb"
}

proc finish {} {
    global ns tf
    $ns flush-trace
    close $tf
    exit 0
}

set tcp_src [$ns node]
set udp_src [$ns node]
set r1 [$ns node]
set r2 [$ns node]
set dst [$ns node]

$ns duplex-link $tcp_src $r1 10Mb 10ms DropTail
$ns duplex-link $udp_src $r1 10Mb 10ms DropTail
$ns duplex-link $r1 $r2 2Mb 20ms DropTail
$ns duplex-link $r2 $dst 10Mb 10ms DropTail
$ns queue-limit $r1 $r2 20

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $tcp_src $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $dst $sink
$ns connect $tcp $sink

set udp [new Agent/UDP]
$ns attach-agent $udp_src $udp
set null [new Agent/Null]
$ns attach-agent $dst $null
$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 1000
$cbr set rate_ 1Mb
$cbr attach-agent $udp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

for {set t 2} {$t <= 50} {incr t} {
    $ns at $t "update_rate"
}

$ns at 1.0 "$ftp start"
$ns at 1.0 "$cbr start"
$ns at 51.0 "finish"
$ns run