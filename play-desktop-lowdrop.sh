#!/bin/bash
#
# Desktop Version - optimiert auf möglichst wenige Drops
# (gut für 3D-Tests auf verschiedenen Displays)
#

if [ -z "$1" ]; then
    echo "Usage: $0 video.mp4"
    exit 1
fi

./run-mpv40.sh \
    --hwdec=rkmpp \
    --vo=gpu --gpu-context=x11egl \
    --scale=bilinear --dscale=bilinear --cscale=bilinear \
    --dither=no --deband=no \
    --correct-downscaling=no --linear-downscaling=no \
    --video-sync=display-desync --framedrop=vo \
    --swapchain-depth=8 --hwdec-extra-frames=24 --vd-lavc-threads=1 \
    --opengl-swapinterval=0 \
    --secenable=yes \
    --input-conf=etc/rock-input.conf \
    "$1"
