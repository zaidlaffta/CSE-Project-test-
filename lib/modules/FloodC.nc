configuration FloodC {
    provides interface Boot;
    provides interface Flood;
}

implementation {
    components FloodP, ActiveMessageC;
    components FloodP;

    Boot = FloodP.Boot;
    Flood = FloodP.Flood;

    FloodP.AMSend -> ActiveMessageC.AMSend[AM_FLOOD];
    FloodP.Receive -> ActiveMessageC.Receive[AM_FLOOD];
}



//      git clone https://github.com/zaidlaffta/CSE160