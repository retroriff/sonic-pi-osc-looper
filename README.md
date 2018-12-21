# sonic-pi-osc-looper
Sonic Pi OSC Looper

Code to allow Sonic Pi create loops and control them using a OSC sender.

This first version user 4 controllers:

1. Play / Stop button
2. Potentiometer 1: Sample file index
3. Potentiometer 2: Sample starting point
4. Potentiometer 3: Sample Length

At the top of the page you must add the samples folder path. 

You can use any OSC sender. These are the cues received by Sonic Pi:

```
/start, 0, 0, 0
/stop, 0
/modulate, 0, 0, 0
```
Start and Modulate commands need the potentiometer values