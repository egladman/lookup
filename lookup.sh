#!/bin/bash

RED="\033[0;31m"
NC="\033[0m" #No color

_log() {
    echo -e ${0##*/}: "${@}" 1>&2
}

_die() {
    _log "${RED}FATAL:${NC} ${@}"
    exit 1
}

function _sendNotification() {
    title="${1}"
    body="${2}"

    case "${OSTYPE}" in
        darwin*)
            #TODO: Close notification after X time
            osascript -e 'display notification "${body}" with title "${title}"'
            ;;
        linux*)
            #TODO: Remove cut dependency
            notification_id=$( \
                gdbus call --session --dest org.freedesktop.Notifications \
                --object-path /org/freedesktop/Notifications \
                --method org.freedesktop.Notifications.Notify lookup \
                42 foo-bar "${title}" "${body}" [] {} 20 | cut -d' ' -f2 | cut -d, -f1
            )

            sleep 20s

            #Close notification
            gdbus call --session --dest org.freedesktop.Notifications \
            --object-path /org/freedesktop/Notifications \
            --method org.freedesktop.Notifications.CloseNotification \
            "${notification_id}" > /dev/null 2>&1
            ;;
    esac
}

#Loosely check if the argument passed in is a number
time="${1}"
if ! [ "${time}" -eq "${time}" ] 2>/dev/null; then
    _die "Not a valid number."
fi

sleep "${time}m"

_sendNotification "Look up" "Look at something 20 feet away for 20 seconds." || _die "Failed to send notification."
