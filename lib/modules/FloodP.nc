// FloodP.nc
module FloodP {
    uses interface Boot;
    uses interface AMSend;
    uses interface Receive;
    uses interface Packet;
    uses interface Flood;

    message_t packet;    // Message buffer for sending packets
    bool received = FALSE; // Flag to check if packet is already received

    event void Boot.booted() {
        // Start flooding the network when the node boots up
        call Flood.floodPacket();
    }

    command void Flood.floodPacket() {
        // Prepare the packet for flooding
        uint8_t *payload = call Packet.getPayload(&packet, sizeof(uint8_t));
        if (payload == NULL) {
            return;
        }

        *payload = 1;  // You can modify the packet content here

        // Broadcast the packet to all nodes
        if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(uint8_t)) != SUCCESS) {
            // Handle send failure
        }
    }

    event void AMSend.sendDone(message_t* msg, error_t error) {
        if (error != SUCCESS) {
            // Handle send error
        }
    }

    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
        // Check if this node has already received the packet
        if (!received) {
            received = TRUE; // Mark packet as received

            // Re-flood the packet to neighbors
            call Flood.floodPacket();
        }

        return msg;
    }
}
