# mega-r3-siggraph-demo

This is an automated demo I put together for a mega-r3 demo for SIGGRAPH 2024. It is designed to run on COSMIC DE. Since pyautogui doesn't work on Wayland, I had to use `ydotool` instead.

## Setup:
Start with a system running Pop!\_OS with COSMIC DE.

1) You need the "Agent 327 Barbershop" blender demo scene from https://svn.blender.org/svnroot/bf-blender/trunk/lib/benchmarks/cycles/barbershop_interior/. Download it and place it directly in your home directory.
2) Install dependencies:
```
sudo apt install alacritty ydotool ydotoold nvtop btop
flatpak install --user org.blender.Blender
```
Note: Blender *MUST* be the flatpak version.
3) Make sure user can use uinput
```
sudo chmod a+rw /dev/uinput
```
Note: This command may need to be run again later if you start seeing "what(): failed to open uinput device" errors

Then this demo should be ready to run!

## Caveats:
- Lines 4 and 5 in barbershop-render-demo.sh set the amount of time it waits for Blender to render before closing all windows and switching rendering methods. This will most likely have to change for different hardware. You may want to leave a margin of time after the render completes before it starts a new one. Both to account for unknown delays, as well as to display the rendered image and the time it took to render it.
- Since ydotool can't handle non en-US keyboard layouts, the system keyboard layout *MUST* be set to en-US.
- As mentioned above, I have seen "what(): failed to open uinput device" errors appear between some reboots. I'm not sure why those permissions weren't preserved, but running `sudo chmod a+rw /dev/uinput` again fixed it and made the demo run normally again.
- I've seen COSMIC DE get into a strange state after running this for a while, which has broken the demo. A reboot was required to fix it, so that may be necessary at the show as well.
