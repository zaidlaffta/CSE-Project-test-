module AppP {
    uses interface Boot;
    uses interface NeighborDiscovery;
    uses interface Flood;

    event void Boot.booted();
    event void NeighborDiscovery.discovered(uint16_t neighborId);
}

implementation {

    event void Boot.booted() {
        // Start the neighbor discovery when the system boots
        call NeighborDiscovery.startDiscovery();
    }

    event void NeighborDiscovery.discovered(uint16_t neighborId) {
        // Trigger flooding once neighbors are discovered
        message_t msg;
        // Optionally, you can prepare the message content here
        call Flood.floodPacket(&msg, sizeof(msg));
    }
}
