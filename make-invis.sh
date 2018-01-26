#! /bin/bash

invis () {
    ppmmake '#000000' $1 $2 > black.ppm
    pbmmake -black $1 $2 > black.pbm
    pnmtopng -alpha black.pbm -force black.ppm
    rm black.ppm black.pbm
}

invis 320 630 >blood-frame.png
invis 464 518 >blood-frame-shadow.png
invis 176 64  >blood-scanner.png
invis 224 96  >blood-scanner-nw-ne.png
invis 232 112 >blood-scanner-sw-se.png
