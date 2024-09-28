# persistent-plane-steering
A simple, very simple, very very simple mod for allowing for realistic taxiing.  Mimics taxiing behavior on ground based on input controls for challenging fun experience

## Under the hood
This script uses a thread called in a function to be run whenever you end up in a plane.  
It runs a thread to 'pause' the wheels returning to the center as it does in the default game allowing for tap-to-steer-controlling
The thread ends once you leave the vehicle, or it's destroyed (more conditionals will be added as they're discovered)

When in the air, the planes wheels reset back to default
When holding left and right 'foot pedals' (aka yaw keys) the steering resets back to default
When parking, the wheel stays in position ;) - and ;( if you don't like it...


Note, it may seem unnecessarily complex, but this is due to the few use-cases I've come across:
1. When using Vmenu and teleporting / spawning into a car, "CEventNetworkPlayerEnteredVehicle" gets triggered twice, so I needed a flag to prevent the event from spawning two separate threads for no reason
2. When restarting the resource, I want the script to account for any players already in vehicles.  This means we have to use a thread flag to track and prevent multiple instances of threads kicking off unnecessarily.

This should alow for appropriate testing, configuration, and some fun.  

To install, follow the same guidance as any resource:
1. Drop the folder into your reosurces folder
2. In the server console, type "start persistent-plane-steer"
3. To enable automagic resource start on server start, simply simply add "ensure persistent-plane-steer" on your resources.cfg folder in your servers base directory;

Enjoy and See you in the skies!
