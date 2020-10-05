#!/bin/bash

echo "Starting X Virtual Framebuffer"
Xvfb :0 &

export DISPLAY=:0

cd /home/
ls -la robot-framework
python3 -m robot --outputdir $RFLOGS robot-framework

