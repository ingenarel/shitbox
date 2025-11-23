die(){
    for (( i = "${#1}"; i > 0; i-- )); do
        printf "="
    done
    printf "\n%s\n" "$1"

    secondBreak="$( for (( i = "${#0}"; i > 0; i-- )); do
        printf "="
    done)"

    echo "$secondBreak"
    echo "$0"
    echo "$secondBreak"
    exit 1
}
