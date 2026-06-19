#!/bin/bash
#
# Desktop Version (X11) - mit Audio
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
    --video-sync=audio --framedrop=vo \
    --swapchain-depth=8 --hwdec-extra-frames=16 \
    --opengl-swapinterval=0 \
    --secenable=yes \
    --input-conf=etc/rock-input.conf \
    "$1"
