##
## Python version of:
##
## ****************************************************************************
## ALTERNATING BIT AND GO-BACK-N NETWORK SIMULATOR: VERSION 1.1  J.F.Kurose
##
## This code should be used for PA2, unidirectional data-transfer protocols
## from A to B.
## Network properties:
##   - one-way network delay averages 5.0 time units (longer if there
##     are other messages in the channel for GBN), but can be larger
##   - packets can be corrupted (either the header or the data portion)
##     or lost, according to user-defined probabilities
##   - packets will be delivered in the order in which they were sent
##     (although some can be lost).
## ****************************************************************************
##
## Python version by:
## Eric Eide <eeide@cs.utah.edu>
## University of Utah
## March 2022
##
## ==> STUDENTS: Implement the methods for EntityA and EntityB.
##
## Run `python3 <thisfile.py> -h` in a terminal window to see the various
## parameters that you can set for a run of this simulator.
##
## This program defines a variable `TRACE` that you can use to conditionally
## print messages from your EntityA and EntityB methods.  For example:
##
##   if TRACE>0:
##       print('A very important event just happened!')
##
## The value of `TRACE` is set by the `-v` command line option.  The default
## value of `TRACE` is 0 (meaning "no tracing").
##

import argparse
from copy import deepcopy
from enum import Enum, auto
import random
import sys
import time

###############################################################################

## ************************* BASIC DATA STRUCTURES ****************************
##
## STUDENTS: Do not modify these definitions.
##
## ****************************************************************************

# A Msg is the data unit passed from layer 5 (teacher's code) to layer 4
# (student's code).  It contains the data (bytes) to be delivered to layer 5
# via the student's transport-level protocol entities.
#
class Msg:
    MSG_SIZE = 20

    def __init__(self, data):
        self.data = data                # type: bytes[MSG_SIZE]

    def __str__(self):
        return 'Msg(data=%s)' % (self.data)

# A Pkt is the data unit passed from layer 4 (student's code) to layer 3
# (teacher's code).  Note the pre-defined packet structure, which all students
# must follow.
#
class Pkt:
    def __init__(self, seqnum, acknum, checksum, payload):
        self.seqnum = seqnum            # type: integer
        self.acknum = acknum            # type: integer
        self.checksum = checksum        # type: integer
        self.payload = payload          # type: bytes[Msg.MSG_SIZE]

    def __str__(self):
        return ('Pkt(seqnum=%s, acknum=%s, checksum=%s, payload=%s)'
                % (self.seqnum, self.acknum, self.checksum, self.payload))

###############################################################################

## ***************** STUDENTS WRITE THE NEXT SEVEN METHODS ********************
##
## STUDENTS: When you implement these methods, use instance variables only!
## I.e., variables that you access through `self' like `self.x`.  Do NOT use
## global variables (a.k.a. module-scoped variables) or class variables.
##
## The reason for this restriction is the autograder, which may run several
## simulations within a single Python process.  For each simulation, the
## autograder will create a new instance of EntityA and a new instance of
## EntityB.  If you use global variables and/or class variables in your
## implmentations of EntityA and EntityB, then your code may not work properly
## when run by the autograder, and you may LOSE POINTS!
##
## If you have any questions about this, please ask the teaching staff.
##
## ****************************************************************************

class EntityA:
    # The following method will be called once (only) before any other
    # EntityA methods are called.  You can use it to do any initialization.
    #
    # seqnum_limit is "the number of distinct seqnum values that your protocol
    # may use."  The seqnums and acknums in all layer3 Pkts must be between
    # zero and seqnum_limit-1, inclusive.  E.g., if seqnum_limit is 16, then
    # all seqnums must be in the range 0-15.
    def __init__(self, seqnum_limit):
        self.seqnum_limit = seqnum_limit
        self.seqnum = 0          
        self.t_increment = 20.0 
        self.wait4ack = False 
        self.packet_buffer = None 

    # Called from layer 5, passed the data to be sent to other side.
    # The argument `message` is a Msg containing the data to be sent.
    def output(self, message):
        if self.wait4ack:
            if TRACE > 0:
                print("A: Layer5 called but waiting for ACK.")
            return
        
        pkt = Pkt(self.seqnum, 0, 0, message.data)
        pkt.checksum = self.calc_checksum(pkt)
        self.packet_buffer = pkt
        
        to_layer3(self, pkt)
        
        start_timer(self, self.t_increment)
        
        self.wait4ack = True
        if TRACE > 0:
            print(f"A: Sent packet seq={self.seqnum}")

    # Called from layer 3, when a packet arrives for layer 4 at EntityA.
    # The argument `packet` is a Pkt containing the newly arrived packet.
    def input(self, packet):
        if not self.wait4ack:
            return

        checksum_ok = self.checksum_check(packet) 
        
        if not checksum_ok:
            if TRACE > 0:
                print("A: Received Corrupt packet. Waiting for Timer.")
            return

        if packet.acknum == 2:
            if TRACE > 0:
                print("A: Received NACK. Retransmitting.")
            stop_timer(self)
            to_layer3(self, self.packet_buffer)
            start_timer(self, self.t_increment)
            return

        if packet.acknum == self.seqnum:
            if TRACE > 0:
                print(f"A: Received correct ACK for seq={self.seqnum}")
            
            stop_timer(self)
            self.wait4ack = False
            self.seqnum = 1 - self.seqnum 
        
        else:
            if TRACE > 0:
                print("A: Received duplicate or wrong ACK.")
            return

    # Called when A's timer goes off.
    def timer_interrupt(self):
        if self.wait4ack:
            if TRACE > 0:
                print(f"A: Timer expired. Retransmitting seq={self.seqnum}")
            to_layer3(self, self.packet_buffer)
            start_timer(self, self.t_increment)

    def calc_checksum(self, pkt):
        checksum = pkt.seqnum + pkt.acknum
        for byte_val in pkt.payload:
            checksum += byte_val
        return checksum
    
    def checksum_check(self, pkt):
        return pkt.checksum == self.calc_checksum(pkt)

class EntityB:
    # The following method will be called once (only) before any other
    # EntityB methods are called.  You can use it to do any initialization.
    #
    # See comment above `EntityA.__init__` for the meaning of seqnum_limit.
    def __init__(self, seqnum_limit):
        self.seqnum_limit = seqnum_limit
        self.exp_seqnum = 0 
        self.payload = b'a' * 20

    # Called from layer 3, when a packet arrives for layer 4 at EntityB.
    # The argument `packet` is a Pkt containing the newly arrived packet.
    def input(self, packet):
        checksum_ok = self.checksum_check(packet) 
        
        if not checksum_ok:
            if TRACE > 0:
                print("B: Received corrupt packet. Sending NACK.")
            # Using 2 for NACK
            sndpkt = Pkt(0, 2, 0, self.payload) 
            sndpkt.checksum = self.calc_checksum(sndpkt)
            to_layer3(self, sndpkt)
            return

        if packet.seqnum == self.exp_seqnum:
            if TRACE > 0:
                print(f"B: Received expected packet seq={packet.seqnum}.")
            
            to_layer5(self, Msg(packet.payload))            
            
            sndpkt = Pkt(self.exp_seqnum, self.exp_seqnum, 0, self.payload)
            sndpkt.checksum = self.calc_checksum(sndpkt)
            to_layer3(self, sndpkt)
            
            self.exp_seqnum = 1 - self.exp_seqnum
            
        else:
            if TRACE > 0:
                print(f"B: Received duplicate packet seq={packet.seqnum}. Sending ACK again!")
            
            sndpkt = Pkt(packet.seqnum, packet.seqnum, 0, self.payload)
            sndpkt.checksum = self.calc_checksum(sndpkt)
            to_layer3(self, sndpkt)
  

    # Called when B's timer goes off.
    def timer_interrupt(self):
        pass # no need in rdt 3.0 for reciever
    
    def calc_checksum(self, pkt):
        checksum = pkt.seqnum + pkt.acknum
        for byte_val in pkt.payload:
            checksum += byte_val
        return checksum
    
    def checksum_check(self, pkt):
        return pkt.checksum == self.calc_checksum(pkt)

###############################################################################

## ********************** STUDENT-CALLABLE FUNCTIONS **************************
##
## STUDENTS: These are functions that should be called from your EntityA and
## EntityB methods.
##
## The first argument to each of these student-callable functions is the object
## that is invoking the function.  Within an EntityA or EntityB method, that
## object is available as `self`.  For example, to start a timer in one of your
## entity methods, you would do something like:
##
##   start_timer(self, 10.0) # Start a timer that will go off in 10 time units.
##
## Or to send a packet to layer3, you would do something like:
##
##   to_layer3(self, Pkt(...)) # Construct a Pkt and send it to layer3.
##
## ****************************************************************************

def start_timer(calling_entity, increment):
    the_sim.start_timer(calling_entity, increment)

def stop_timer(calling_entity):
    the_sim.stop_timer(calling_entity)

def to_layer3(calling_entity, packet):
    the_sim.to_layer3(calling_entity, packet)

def to_layer5(calling_entity, message):
    the_sim.to_layer5(calling_entity, message)

def get_time(calling_entity):
    return the_sim.get_time(calling_entity)

###############################################################################

## ****************************************************************************
## ***************** NETWORK SIMULATION CODE STARTS BELOW *********************
##
## The code below simulates the layer 3 and below network environment:
##   - simulates the tranmission and delivery (possibly with bit-level
##     corruption and packet loss) of packets across the layer 3/4 interface
##   - handles the starting/stopping of a timer, and generates timer
##     interrupts (resulting in calling student's timer handler).
##   - generates message to be sent (passed from later 5 to 4)
##
## THERE IS NO REASON THAT ANY STUDENT SHOULD HAVE TO READ OR UNDERSTAND
## THE CODE BELOW.  YOU SHOULD NOT TOUCH OR REFERENCE (in your code) ANY
## OF THE DATA STRUCTURES BELOW.  If you're interested in how I designed
## the simulator, you're welcome to look at the code - but again, you should
## not have to, and you definitely should not have to modify.
##
## ****************************************************************************

class EventType(Enum):
    TIMER_INTERRUPT = auto()
    FROM_LAYER5 = auto()
    FROM_LAYER3 = auto()

class Event:
    def __init__(self, ev_time, ev_type, ev_entity, packet=None):
        self.ev_time = ev_time      # float
        self.ev_type = ev_type      # EventType
        self.ev_entity = ev_entity  # EntityA or EntityB
        self.packet = packet        # Pkt or None

class Simulator:
    def __init__(self, options, cbA=None, cbB=None):
        self.n_sim                = 0
        self.n_sim_max            = options.num_msgs
        self.time                 = 0.000
        self.interarrival_time    = options.interarrival_time
        self.loss_prob            = options.loss_prob
        self.corrupt_prob         = options.corrupt_prob
        self.seqnum_limit         = options.seqnum_limit
        self.n_to_layer3_A        = 0
        self.n_to_layer3_B        = 0
        self.n_lost               = 0
        self.n_corrupt            = 0
        self.n_to_layer5_A        = 0
        self.n_to_layer5_B        = 0

        if options.random_seed is None:
            self.random_seed      = time.time_ns()
        else:
            self.random_seed      = options.random_seed
        random.seed(self.random_seed)

        if self.seqnum_limit < 2:
            self.seqnum_limit_n_bits = 0
        else:
            # How many bits to represent integers in [0, seqnum_limit-1]?
            self.seqnum_limit_n_bits = (self.seqnum_limit-1).bit_length()

        self.trace                = options.trace
        self.to_layer5_callback_A = cbA
        self.to_layer5_callback_B = cbB

        self.entity_A             = EntityA(self.seqnum_limit)
        self.entity_B             = EntityB(self.seqnum_limit)
        self.event_list           = []

    def get_stats(self):
        stats = {'n_sim'             : self.n_sim,
                 'n_sim_max'         : self.n_sim_max,
                 'time'              : self.time,
                 'interarrival_time' : self.interarrival_time,
                 'loss_prob'         : self.loss_prob,
                 'corrupt_prob'      : self.corrupt_prob,
                 'seqnum_limit'      : self.seqnum_limit,
                 'random_seed'       : self.random_seed,
                 'n_to_layer3_A'     : self.n_to_layer3_A,
                 'n_to_layer3_B'     : self.n_to_layer3_B,
                 'n_lost'            : self.n_lost,
                 'n_corrupt'         : self.n_corrupt,
                 'n_to_layer5_A'     : self.n_to_layer5_A,
                 'n_to_layer5_B'     : self.n_to_layer5_B
        }
        return stats

    def run(self):
        if self.trace>0:
            print('\n===== SIMULATION BEGINS')

        self._generate_next_arrival()

        while (self.event_list
               and self.n_sim < self.n_sim_max):
            ev = self.event_list.pop(0)
            if self.trace>2:
                print(f'\nEVENT time: {ev.ev_time}, ', end='')
                if ev.ev_type == EventType.TIMER_INTERRUPT:
                    print(f'timer_interrupt, ', end='')
                elif ev.ev_type == EventType.FROM_LAYER5:
                    print(f'from_layer5, ', end='')
                elif ev.ev_type == EventType.FROM_LAYER3:
                    print(f'from_layer3, ', end='')
                else:
                    print(f'unknown_type, ', end='')
                print(f'entity: {ev.ev_entity}')

            self.time = ev.ev_time

            if ev.ev_type == EventType.FROM_LAYER5:
                self._generate_next_arrival()
                j = self.n_sim % 26
                m = bytes([97+j for i in range(Msg.MSG_SIZE)])
                if self.trace>2:
                    print(f'          MAINLOOP: data given to student: {m}')
                self.n_sim += 1
                ev.ev_entity.output(Msg(m))

            elif ev.ev_type == EventType.FROM_LAYER3:
                ev.ev_entity.input(deepcopy(ev.packet))

            elif ev.ev_type == EventType.TIMER_INTERRUPT:
                ev.ev_entity.timer_interrupt()

            else:
                print('INTERNAL ERROR: unknown event type; event ignored.')

        if self.trace>0:
            print('===== SIMULATION ENDS')

    def _insert_event(self, event):
        if self.trace>2:
            print(f'            INSERTEVENT: time is {self.time}')
            print(f'            INSERTEVENT: future time will be {event.ev_time}')
        # Python 3.10+: use the bisect module:
        # insort(self.event_list, event, key=lambda e: e.ev_time)
        i = 0
        while (i < len(self.event_list)
               and self.event_list[i].ev_time < event.ev_time):
            i += 1
        self.event_list.insert(i, event)

    def _generate_next_arrival(self):
        if self.trace>2:
            print('          GENERATE NEXT ARRIVAL: creating new arrival')

        x = self.interarrival_time * 2.0 * random.random()
        ev = Event(self.time+x, EventType.FROM_LAYER5, self.entity_A)
        self._insert_event(ev)

    #####

    def _valid_entity(self, e, method_name):
        if (e is self.entity_A
            or e is self.entity_B):
            return True
        print(f'''WARNING: entity in call to `{method_name}` is invalid!
  Invalid entity: {e}
  Call ignored.''')
        return False

    def _valid_increment(self, i, method_name):
        if ((type(i) is int or type(i) is float)
            and i >= 0.0):
            return True
        print(f'''WARNING: increment in call to `{method_name}` is invalid!
  Invalid increment: {i}
  Call ignored.''')
        return False

    def _valid_message(self, m, method_name):
        if (type(m) is Msg
            and type(m.data) is bytes
            and len(m.data) == Msg.MSG_SIZE):
            return True
        print(f'''WARNING: message in call to `{method_name}` is invalid!
  Invalid message: {m}
  Call ignored.''')
        return False

    def _valid_packet(self, p, method_name):
        if (type(p) is Pkt
            and type(p.seqnum) is int
            and 0 <= p.seqnum < self.seqnum_limit
            and type(p.acknum) is int
            and 0 <= p.acknum < self.seqnum_limit
            and type(p.checksum) is int
            and type(p.payload) is bytes
            and len(p.payload) == Msg.MSG_SIZE):
            return True
        # Issue special warnings for invalid seqnums and acknums.
        if (type(p.seqnum) is int
            and not (0 <= p.seqnum < self.seqnum_limit)):
            print(f'''WARNING: seqnum in call to `{method_name}` is invalid!
  Invalid packet: {p}
  Call ignored.''')
        elif (type(p.acknum) is int
              and not (0 <= p.acknum < self.seqnum_limit)):
            print(f'''WARNING: acknum in call to `{method_name}` is invalid!
  Invalid packet: {p}
  Call ignored.''')
        else:
            print(f'''WARNING: packet in call to `{method_name}` is invalid!
  Invalid packet: {p}
  Call ignored.''')
        return False

    #####

    def start_timer(self, entity, increment):
        if not self._valid_entity(entity, 'start_timer'):
            return
        if not self._valid_increment(increment, 'start_timer'):
            return

        if self.trace>2:
            print(f'          START TIMER: starting timer at {self.time}')

        for e in self.event_list:
            if (e.ev_type == EventType.TIMER_INTERRUPT
                and e.ev_entity is entity):
                print('WARNING: attempt to start a timer that is already started!')
                return

        ev = Event(self.time+increment, EventType.TIMER_INTERRUPT, entity)
        self._insert_event(ev)

    def stop_timer(self, entity):
        if not self._valid_entity(entity, 'stop_timer'):
            return

        if self.trace>2:
            print(f'          STOP TIMER: stopping timer at {self.time}')

        i = 0
        while i < len(self.event_list):
            if (self.event_list[i].ev_type == EventType.TIMER_INTERRUPT
                and self.event_list[i].ev_entity is entity):
                break
            i += 1
        if i < len(self.event_list):
            self.event_list.pop(i)
        else:
            print('WARNING: unable to stop timer; it was not running.')

    def to_layer3(self, entity, packet):
        if not self._valid_entity(entity, 'to_layer3'):
            return
        if not self._valid_packet(packet, 'to_layer3'):
            return

        if entity is self.entity_A:
            receiver = self.entity_B
            self.n_to_layer3_A += 1
        else:
            receiver = self.entity_A
            self.n_to_layer3_B += 1

        # Simulate losses.
        if random.random() < self.loss_prob:
            self.n_lost += 1
            if self.trace>0:
                print('          TO_LAYER3: packet being lost')
            return

        seqnum = packet.seqnum
        acknum = packet.acknum
        checksum = packet.checksum
        payload = packet.payload

        # Simulate corruption.
        if random.random() < self.corrupt_prob:
            self.n_corrupt += 1
            x = random.random()
            if (x < 0.75
                or self.seqnum_limit_n_bits == 0):
                payload = b'Z' + payload[1:]
            elif x < 0.875:
                # Flip a random bit in the seqnum.
                # The result might be greater than seqnum_limit if seqnum_limit
                # is not a power of two.  This is OK.
                # Recall that randrange(x) returns an int in [0, x).
                seqnum ^= 2**random.randrange(self.seqnum_limit_n_bits)
                # Kurose's simulator simply did:
                # seqnum = 999999
            else:
                # Flip a random bit in the acknum.
                acknum ^= 2**random.randrange(self.seqnum_limit_n_bits)
                # Kurose's simulator simply did:
                # acknum = 999999
            if self.trace>0:
                print('          TO_LAYER3: packet being corrupted')

        # Compute the arrival time of packet at the other end.
        # Medium cannot reorder, so make sure packet arrives between 1 and 9
        # time units after the latest arrival time of packets
        # currently in the medium on their way to the destination.
        last_time = self.time
        for e in self.event_list:
            if (e.ev_type == EventType.FROM_LAYER3
                and e.ev_entity is receiver):
                last_time = e.ev_time
        arrival_time = last_time + 1.0 + 8.0*random.random()

        p = Pkt(seqnum, acknum, checksum, payload)
        ev = Event(arrival_time, EventType.FROM_LAYER3, receiver, p)
        if self.trace>2:
            print('          TO_LAYER3: scheduling arrival on other side')
        self._insert_event(ev)

    def to_layer5(self, entity, message):
        if not self._valid_entity(entity, 'to_layer5'):
            return
        if not self._valid_message(message, 'to_layer5'):
            return

        if entity is self.entity_A:
            self.n_to_layer5_A += 1
            callback = self.to_layer5_callback_A
        else:
            self.n_to_layer5_B += 1
            callback = self.to_layer5_callback_B

        if self.trace>2:
            print(f'          TO_LAYER5: data received: {message.data}')
        if callback:
            callback(message.data)

    def get_time(self, entity):
        if not self._valid_entity(entity, 'get_time'):
            return
        return self.time

###############################################################################

TRACE = 0

the_sim = None

def report_config():
    stats = the_sim.get_stats()
    print(f'''SIMULATION CONFIGURATION
--------------------------------------
(-n) # layer5 msgs to be provided:      {stats['n_sim_max']}
(-d) avg layer5 msg interarrival time:  {stats['interarrival_time']}
(-z) transport protocol seqnum limit:   {stats['seqnum_limit']}
(-l) layer3 packet loss prob:           {stats['loss_prob']}
(-c) layer3 packet corruption prob:     {stats['corrupt_prob']}
(-s) simulation random seed:            {stats['random_seed']}
--------------------------------------''')

def report_results():
    stats = the_sim.get_stats()
    time = stats['time']
    if time > 0.0:
        tput = stats['n_to_layer5_B']/time
    else:
        tput = 0.0
    print(f'''\nSIMULATION SUMMARY
--------------------------------
# layer5 msgs provided to A:      {stats['n_sim']}
# elapsed time units:             {stats['time']}

# layer3 packets sent by A:       {stats['n_to_layer3_A']}
# layer3 packets sent by B:       {stats['n_to_layer3_B']}
# layer3 packets lost:            {stats['n_lost']}
# layer3 packets corrupted:       {stats['n_corrupt']}
# layer5 msgs delivered by A:     {stats['n_to_layer5_A']}
# layer5 msgs delivered by B:     {stats['n_to_layer5_B']}
# layer5 msgs by B/elapsed time:  {tput}
--------------------------------''')

def main(options, cb_A=None, cb_B=None):
    global TRACE
    TRACE = options.trace

    global the_sim
    the_sim = Simulator(options, cb_A, cb_B)
    report_config()
    the_sim.run()

#####

if __name__ == '__main__':
    desc = 'Run a simulation of a reliable data transport protocol.'
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('-n', type=int, default=10,
                        dest='num_msgs',
                        help=('number of messages to simulate'
                              ' [int, default: %(default)s]'))
    parser.add_argument('-d', type=float, default=100.0,
                        dest='interarrival_time',
                        help=('average time between messages'
                              ' [float, default: %(default)s]'))
    parser.add_argument('-z', type=int, default=16,
                        dest='seqnum_limit',
                        help=('seqnum limit for data transport protocol; '
                              'all packet seqnums must be >=0 and <limit'
                              ' [int, default: %(default)s]'))
    parser.add_argument('-l', type=float, default=0.0,
                        dest='loss_prob',
                        help=('packet loss probability'
                              ' [float, default: %(default)s]'))
    parser.add_argument('-c', type=float, default=0.0,
                        dest='corrupt_prob',
                        help=('packet corruption probability'
                              ' [float, default: %(default)s]'))
    parser.add_argument('-s', type=int,
                        dest='random_seed',
                        help=('seed for random number generator'
                              ' [int, default: %(default)s]'))
    parser.add_argument('-v', type=int, default=0,
                        dest='trace',
                        help=('level of event tracing'
                              ' [int, default: %(default)s]'))
    options = parser.parse_args()

    main(options)
    report_results()
    sys.exit(0)

###############################################################################

## End of program.
