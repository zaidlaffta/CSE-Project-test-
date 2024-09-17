configuration FloodC {
    provides interface Boot;
    provides interface Flood;
}

implementation {
    components FloodP, ActiveMessageC;

    Boot = FloodP.Boot;
    Flood = FloodP.Flood;

    FloodP.AMSend -> ActiveMessageC.AMSend[AM_FLOOD_MSG];
    FloodP.Receive -> ActiveMessageC.Receive[AM_FLOOD_MSG];
}
