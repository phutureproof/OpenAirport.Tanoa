// force the loading screen to close 


_EndSplashScreen = {
    for "_x" from 1 to 10 do {
        endLoadingScreen;
        sleep 5;
    };
};

[] spawn _EndSplashScreen;
