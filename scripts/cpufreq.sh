#!/usr/bin/env bash

main(){
    [[ -n "$1" ]] || { echo -e "cpufreq.sh <cpufreq>\nLast digit is counted as the decimal point\nSo 34 == 3.4GHz"; return 1; }
    [[ "$1" -ge 10 ]] || { echo "invalid cpu freq, should be an int and minimum 10 "; return 1; }
    local cpuFreq="$(( $1 * 100000))"

    for core in /sys/devices/system/cpu/cpu[0-9]*; do
        local maxFreq=$(< "$core/cpufreq/cpuinfo_max_freq")

        [[ "$cpuFreq" -gt "$maxFreq" ]]\
            &&
        {
            echo "cpu freq is higher than maxFreq avaliable, which is $maxFreq";
            return 1;
        }\
            ||
        echo "$cpuFreq" | tee "$core/cpufreq/scaling_max_freq"
    done
}

main $1
