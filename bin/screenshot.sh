#!/usr/bin/env bash

cd $HOME/Pictures

maim "$(date +%Y-%m-%dT%H-%M-%S).png"

notify-send -u low ScreenShot 'done!' 
