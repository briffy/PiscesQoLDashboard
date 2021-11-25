#!/bin/bash
adduser --disabled-password --gecos "" boris
echo boris:knockers | chpasswd
usermod boris -g sudo
