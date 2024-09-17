interface NeighborDiscovery {
    command void startDiscovery();
    event void discovered(uint16_t neighborId);
}
