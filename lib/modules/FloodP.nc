module FloodP {
    uses interface Boot;
    uses interface AMSend;
    uses interface Packet;
    uses interface Receive;
    uses interface Flood;

    event void Boot.booted();
    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len);
}

implementation {
    message_t packet;
    bool packetReceived = FALSE;

    event void Boot.booted() {
        // Initialize and send the first flood packet
        call Flood.floodPacket();
    }

    command void Flood.floodPacket() {
        if (!call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(packet))) {
            // Error handling if send fails
        }
    }

    event void AMSend.sendDone(message_t* msg, error_t error) {
        if (error != SUCCESS) {
            // Handle send error
        }
    }

    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
        if (!packetReceived) {
            // Process packet and mark as received
            packetReceived = TRUE;
            // Forward the packet to neighbors
            call Flood.floodPacket();
        }
        return msg;
    }
}
