configuration NeighborDiscoveryC {
    provides interface Boot;
    provides interface Flood;  // Provide the Flood interface here
}

implementation {
    components NeighborDiscoveryP;

    Boot = NeighborDiscoveryP.Boot;
    Flood = NeighborDiscoveryP.Flood;  // Wire the Flood interface here
}
