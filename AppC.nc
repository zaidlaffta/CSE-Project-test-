
configuration AppC {
    includes interface Boot;
}

implementation {
    components MainC, NeighborDiscoveryC, FloodC;

    // MainC provides Boot, NeighborDiscoveryC requires it
    MainC.Boot -> NeighborDiscoveryC.Boot;

    // NeighborDiscoveryC requires Flood, FloodC provides it
    NeighborDiscoveryC.Flood -> FloodC.Flood;
}
