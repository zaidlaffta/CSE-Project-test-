configuration AppC {
    includes interface Boot;    // Include the Boot interface (provided by MainC)
}

implementation {
    components MainC, NeighborDiscoveryC, FloodC;

    // Wire Boot from MainC to NeighborDiscoveryC so it can start on boot
    MainC.Boot -> NeighborDiscoveryC.Boot;

    // Wire Flood interface between NeighborDiscoveryC and FloodC
    NeighborDiscoveryC.Flood -> FloodC.Flood;
}
