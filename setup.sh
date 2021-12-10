#!/bin/bash
echo admin:admin | chpasswd
usermod admin -g sudo
