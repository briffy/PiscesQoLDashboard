#!/bin/bash

sync; echo 3 > /proc/sys/vm/drop_caches; sync
sync; dphys-swapfile swapoff; sync; dphys-swapfile swapon; sync
