#!/usr/bin/bash

# Change these delays (in seconds) according to the amount of time each render takes to complete (leave a generous margin at the end)
gpu_render_wait=120
cpu_render_wait=120

launch_btop () {
    # Launch btop in Alacritty (because it behaves best for this demo)
    ydotool key Super
    sleep 0.1
    ydotool type "alacritty"
    sleep 0.2
    ydotool key Enter
    sleep 0.1
    ydotool type "btop"
    sleep 0.2
    ydotool key Enter
    sleep 0.2
    
    # Now move alacritty out of the stack, to the bottom of the screen, then focus back up to the stack
    ydotool key Super+Shift+down
    sleep 0.1
    ydotool key Super+up
    sleep 0.1
}

launch_nvtop () {
    # Launch nvtop in cosmic-term
    ydotool key Super+t
    sleep 0.1
    ydotool type "nvtop"
    sleep 0.2
    ydotool key Enter
    sleep 0.2
    
    # Now move this terminal out of the stack, to the bottom of the screen, then focus back up to the stack
    ydotool key Super+Shift+down
    sleep 0.1
    ydotool key Super+up
    sleep 0.1
}

gpu_render () {
    # Open terminal, stack it, and open barber shop demo in Blender (forced to enable GPUS_COMPUTE with a random Python script from stackoverflow)
    ydotool key Super+t
    sleep 0.5
    ydotool key Super+s
    ydotool type "flatpak run org.blender.Blender ~/barbershop_interior.blend -P ~/enable-gpus.py"
    sleep 0.5
    ydotool key Enter
    sleep 12
    
    # Un-maximize, since Blender always launches maximized...
    ydotool key Super+m
    sleep 1
    
    # Launch nvtop so we can watch GPU load
    launch_nvtop
    
    # Now, render!
    ydotool key F12
}

cpu_render () {
    # Open a terminal, stack it, and open barber shop demo in Blender
    ydotool key Super+t
    sleep 0.5
    ydotool key Super+s
    ydotool type "flatpak run org.blender.Blender ~/barbershop_interior.blend"
    sleep 0.5
    ydotool key Enter
    sleep 12
    
    # Un-maximize, since blender always launches maximized...
    ydotool key Super+m
    sleep 1
    
    # Launch btop so we can watch CPU load
    launch_btop
    
    # Now, render!
    ydotool key F12
}

close_everything () {
    for i in {1..6}; 
    do
        ydotool key Super+q
        sleep 0.2
    done
}

echo "Initializing Barber Shop demo..."
sleep 1
echo "To exit demo, return to this terminal and kill the process with Ctrl + C"
echo "Before re-launching the demo, close ALL windows on the workspace below this one."
echo "If there are any open windows on the next workspace when you launch the demo, strange and undesirable things will happen."
sleep 10

# New workspace below
ydotool key Super+Ctrl+Down
sleep 0.5

while :
do
    sleep 1
    
    gpu_render
    sleep $gpu_render_wait
    close_everything
    sleep 2
    
    cpu_render
    sleep $cpu_render_wait
    close_everything
    sleep 2
done
