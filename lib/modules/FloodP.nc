module FloodP {
    uses interface Boot;
    uses interface AMSend;
    uses interface Receive;
    uses interface Flood;

    event void Boot.booted();
    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len);
}

implementation {
    message_t floodPacket;
    bool packetForwarded = FALSE;

    event void Boot.booted() {
        // Optionally flood on boot
    }

    command void Flood.floodPacket(message_t* msg, uint8_t len) {
        if (!call AMSend.send(AM_BROADCAST_ADDR, msg, len)) {
            // Handle send failure
        }
    }

    event void AMSend.sendDone(message_t* msg, error_t error) {
        if (error != SUCCESS) {
            // Handle send failure
        }
    }

    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
        if (!packetForwarded) {
            packetForwarded = TRUE;
            call Flood.floodPacket(msg, len);  // Forward the message to all neighbors
        }
        return msg;
    }
}
