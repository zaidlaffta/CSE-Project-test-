configuration NeighborDiscoveryC {
    provides interface Boot;
    provides interface Flood;
}

implementation {
    components NeighborDiscoveryP;

    Boot = NeighborDiscoveryP.Boot;
    Flood = NeighborDiscoveryP.Flood;
}
