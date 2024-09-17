configuration AppC {
    includes interface Boot;
}

implementation {
    components MainC, NeighborDiscoveryC, FloodC;

    Boot = NeighborDiscoveryC.Boot;  // Trigger neighbor discovery on boot
    NeighborDiscoveryC.Flood -> FloodC.Flood;  // Wire neighbor discovery to flooding
}
