# Sonic Pi OSC Looper

Sonic Pi code to create live loops from a samples folder and control them using a OSC sender.

The looper currently use 4 controllers:

1. Button 1: Play / Stop
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
"/start" and "/modulate" commands require the potentiometer values