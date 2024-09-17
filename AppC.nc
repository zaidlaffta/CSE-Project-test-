configuration AppC {
    includes interface Boot;
    includes interface Flood;  // Include the Flood interface
}

implementation {
    components MainC, NeighborDiscoveryC, FloodC;

    Boot = MainC.Boot;  // Boot the system from MainC

    NeighborDiscoveryC.Boot -> Boot;
    NeighborDiscoveryC.Flood -> FloodC.Flood;  // Wire neighbor discovery to flooding
}
