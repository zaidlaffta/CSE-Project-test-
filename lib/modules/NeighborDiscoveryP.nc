module NeighborDiscoveryP {
    uses interface Boot;
    uses interface AMSend;
    uses interface Receive;
    uses interface NeighborDiscovery;

    event void Boot.booted();
    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len);
}

implementation {
    message_t discoverPacket;
    uint16_t neighbors[10];
    uint8_t neighborCount = 0;

    event void Boot.booted() {
        call NeighborDiscovery.startDiscovery();
    }

    command void NeighborDiscovery.startDiscovery() {
        if (!call AMSend.send(AM_BROADCAST_ADDR, &discoverPacket, sizeof(discoverPacket))) {
            // Handle send failure
        }
    }

    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
        uint16_t neighborId = call Packet.source(msg);
        
        // Check if the neighbor is already discovered
        bool known = FALSE;
        for (uint8_t i = 0; i < neighborCount; i++) {
            if (neighbors[i] == neighborId) {
                known = TRUE;
                break;
            }
        }

        // Add new neighbor
        if (!known && neighborCount < 10) {
            neighbors[neighborCount++] = neighborId;
            signal NeighborDiscovery.discovered(neighborId);
        }
        
        return msg;
    }
}
