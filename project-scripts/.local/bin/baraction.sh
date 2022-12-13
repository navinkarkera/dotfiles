#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian Buster(with newest spectrwm built from source), Debian Bullseye, Devuan Chimaera, Devuan Ceres
# This config can be found on github.com/linuxdabbler

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

##############################
#	    DISK
##############################

hddicon() {
    echo ""
}

hdd() {
    free="$(df -h /home | grep /dev | awk '{print $3}' | sed 's/G/Gb/')"
    perc="$(df -h /home | grep /dev/ | awk '{print $5}')"
    echo "$perc  ($free)"
}
##############################
#	    RAM
##############################
memicon() {
    echo ""
}

mem() {
    used="$(free | grep Mem: | awk '{print $3}')"
    total="$(free | grep Mem: | awk '{print $2}')"
    human="$(free -h | grep Mem: | awk '{print $3}' | sed s/i//g)"

    ram="$(( 200 * $used/$total - 100 * $used/$total ))% ($human) "

    echo "$ram"
}
##############################
#	    CPU
##############################
cpuicon() {
    echo ""
}

cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo "$cpu%"
}
##############################
#	    VOLUME
##############################
volicon() {
    VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"

    VOLON="蓼"
    VOLOFF="遼"

    if [ "$VOLONOFF" = "on" ]; then
        echo "$VOLON"
    else
        echo "$VOLOFF"
    fi
}

vol() {
    VOL="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $5}')"

    echo "$VOL"
}
##############################
#	    Packages
##############################
pkgicon() {
    echo ""
}

##############################
#	    NETWORK
##############################
networkicon() {
    wire="$(ip a | grep "eth0\|eno" | grep inet | wc -l)"
    wifi="$(ip a | grep wlan | grep inet | wc -l)"

    if [ $wire = 1 ]; then
        echo ""
    elif [ $wifi = 1 ]; then
        echo ""
    else
        echo "睊"
    fi

}

ipaddress() {
    address="$(ip a | grep .255 | grep -v wlp | cut -d ' ' -f6 | sed 's/\/24//')"
    echo "$address"
}

vpnconnection() {
    state="$(ip a | grep tun0 | grep inet | wc -l)"

    if [ $state = 1 ]; then
        echo "ﱾ"
    else
        echo ""
    fi
}

## BATTERY
bat() {
    batstat="$(cat /sys/class/power_supply/BAT0/status)"
    battery="$(cat /sys/class/power_supply/BAT0/capacity)"
    if [ $batstat = 'Unknown' ]; then
        batstat=""
    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
        batstat=""
    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
        batstat=""
    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
        batstat=""
    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
        batstat=""
    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
        batstat=""
    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
        batstat=""
    fi

    echo "$batstat  $battery %"
}

clockicon() {
    CLOCK=$(date '+%I')

    case "$CLOCK" in
        "00") icon="" ;;
        "01") icon="" ;;
        "02") icon="" ;;
        "03") icon="" ;;
        "04") icon="" ;;
        "05") icon="" ;;
        "06") icon="" ;;
        "07") icon="" ;;
        "08") icon="" ;;
        "09") icon="" ;;
        "10") icon="" ;;
        "11") icon="" ;;
        "12") icon="" ;;
    esac

    echo "$(date "+$icon")"
}

dateinfo() {
    echo "$(date "+%b %d %Y (%a)")"
}

clockinfo() {
    echo $(date "+%I:%M%p")
}

timetracker() {
    echo "Tracking: $(echo $(timew | grep 'Total')) | $(echo $(timew day | grep 'Tracked'))"
}


SLEEP_SEC=1
#loops forever outputting a line every SLEEP_SEC secs
while :; do
    # echo "$(cpu) | $(mem) | $(pkgs) | $(upgrades) | $(hdd) | $(vpn) $(network) | $(vol) | $(WEATHER) $(TEMP) "
    # echo "+@fg=1; $(cpuicon) +@fg=0; $(cpu)\
        # +@fg=3; $(hddicon) +@fg=0; $(hdd)\
    echo "+@fg=6; $(timetracker) +@fg=0; +@fg=1; $(memicon) +@fg=0; $(mem)\
        +@fg=4; $(networkicon) \
        +@fg=5; $(volicon) +@fg=0; $(vol)\
        +@fg=1; $(dateinfo) +@fg=4; $(clockicon) +@fg=0; $(clockinfo)"
    sleep $SLEEP_SEC
done
