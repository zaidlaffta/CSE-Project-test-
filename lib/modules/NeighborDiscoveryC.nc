configuration NeighborDiscoveryC {
    provides interface Boot;
    provides interface NeighborDiscovery;
}

implementation {
    components NeighborDiscoveryP, ActiveMessageC;

    Boot = NeighborDiscoveryP.Boot;
    NeighborDiscovery = NeighborDiscoveryP.NeighborDiscovery;

    NeighborDiscoveryP.AMSend -> ActiveMessageC.AMSend[AM_NEIGHBOR_DISCOVERY];
    NeighborDiscoveryP.Receive -> ActiveMessageC.Receive[AM_NEIGHBOR_DISCOVERY];
}
