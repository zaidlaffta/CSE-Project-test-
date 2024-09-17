module AppP {
    uses interface Boot;
    uses interface NeighborDiscovery;
    uses interface Flood;

    event void Boot.booted() {
        // Start neighbor discovery on boot
        call NeighborDiscovery.startDiscovery();
    }

    event void NeighborDiscovery.discovered(uint16_t neighborId) {
        // Send flood message when a neighbor is discovered
        message_t msg;
        call Flood.floodPacket(&msg, sizeof(msg));
    }
}
