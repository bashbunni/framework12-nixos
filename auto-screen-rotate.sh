#!/bin/sh

# Automatically rotate the screen when the device's orientation changes.
# Use 'xrandr' to get the correct display for the first argument (for example, "eDP-1"),
# and 'xinput' to get the correct input element for your touch screen, if applicable
# (for example,  "Wacom HID 486A Finger").
#
# The script depends on the monitor-sensor program from the iio-sensor-proxy package.
# source: https://gist.github.com/mortie/e725d37a71779b18e8eaaf4f8a02bf5b
DISPLAYNAME="eDP-1"
monitor-sensor | while read -r line; do
    case "$line" in
        *"orientation changed: normal"*)
            echo "right side up"
            xrandr --output "$DISPLAYNAME" --rotate normal
            i3-msg "bar mode dock" ;;
        *"orientation changed: left-up"*)
            xrandr --output "$DISPLAYNAME" --rotate left
            i3-msg "bar mode invisible" ;;
        *"orientation changed: right-up"*)
            xrandr --output "$DISPLAYNAME" --rotate right
            i3-msg "bar mode invisible" ;;
        *"orientation changed: bottom-up"*)
	    echo "upside down"
            xrandr --output "$DISPLAYNAME" --rotate inverted
            i3-msg "bar mode dock" ;;
    esac
done
