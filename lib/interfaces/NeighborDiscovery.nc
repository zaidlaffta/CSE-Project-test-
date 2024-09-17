interface NeighborDiscovery {
    command void startDiscovery();
    event void discovered(uint16_t neighborId);
}
interface Flood {
    command void floodPacket(message_t* msg, uint8_t len);
}
