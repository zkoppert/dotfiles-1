DO_COVER() {
    tput bold
    tput setaf 1
    echo "--------------------------------------" | nms -asf blue
    figlet "Anonymous" | nms -asf red || return 0
    tput sgr0
    echo "[Press Any Key]" | nms -af blue
    echo "[➜ ➜ ➜ ➜ ➜ ➜ ➜ ➜ ➜]" | nms -f blue
    DO_MOTTO
    MINI_SYS_INFO
}
DO_MOTTO() {
    tput bold
    tput setaf 1
    echo "                  Who Speak Out Against..." | nms -asf red

    tput bold
    echo "- Will Be silenced" | nms -asf white
    echo "                  Those Who Lie..." | nms -asf red
    tput bold
    echo "- Will Vanish." | nms -asf white
    tput bold
    tput setaf 2
    sleep 2
    tput bold
    echo "                We are anonymous" | nms -asf red
    echo "                We are legion" | nms -asf red
    echo "                We do not forgive" | nms -asf red
    echo "                We do not forget" | nms -asf red
    sleep 2
    tput bold
    echo "                EXPECT US" | nms -asf white
    tput sgr0
}
MINI_SYS_INFO() {
    DO_MOTTO
    upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    secs="$((upSeconds % 60))"
    mins="$((upSeconds / 60 % 60))"
    hours=$((upSeconds / 3600 % 24))
    days=$((upSeconds / 86400))
    UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")
    read -r one five fifteen rest </proc/loadavg

    #$(tput sgr0)- IP Addresses.......: $(hostname | /usr/bin/cut -d " " -f 1) and $(wget -q -O - http://icanhazip.com/ | tail)
    echo "$(tput setaf 2)
$(date +"%A, %e %B %Y, %r")
$(uname -srmo) 
$(tput sgr0)- Uptime.............: ${UPTIME}
$(tput sgr0)- Memory.............: $(free | grep Mem | awk '{print $3/1024}') MB (Used) / $(cat /proc/meminfo | grep MemTotal | awk {'print $2/1024'}) MB (Total)
$(tput sgr0)- Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
$(tput sgr0)- Running Processes..: $(ps ax | wc -l | tr -d " ")
$(tput sgr0)"
}
