#!/bin/bash

INPUT_FILE="words.txt"
OUTPUT_FILE="german_passwords.txt"

# Validate arguments - isch Argument Korrekt
if [[ -z "$1" || ! "$1" =~ ^[0-9]+$ || "$1" -le 0 ]]; then
    echo "Usage: $0 <passwords_per_word> [--leet|-l]"
    exit 1
fi

max_per_word="$1"
enable_leet=false

# Optional leet flag - Sollen wir Zahlen nehmen?
if [[ "$2" == "--leet" || "$2" == "-l" ]]; then
    enable_leet=true
fi

# Clear output - Kehrwoche
> "$OUTPUT_FILE"

# Suffixes, Änder so wies gebraucht wird
suffixes=("2025" "2024" "1" "123")
#suffixes=("2025" "2024" "1" "123" "0815" "96" "88" "04")

# Weighted symbols, hier kannsch die Gewichte ändern
symbols=()
for ((i = 0; i < 65; i++)); do symbols+=("!"); done
for ((i = 0; i < 20; i++)); do symbols+=("@"); done
for ((i = 0; i < 10; i++)); do symbols+=("?"); done
symbols+=("#" "$" "%" "&" "*" "+")

# Capitalize first letter - Immer schön Großschreiben
capitalize() {
    echo "$(tr '[:lower:]' '[:upper:]' <<< "${1:0:1}")${1:1}"
}

# Check complexity: 8+ chars, upper, lower, number, symbol, Ist das auch schön BSI Compliant?
is_complex() {
    pw="$1"
    [[ ${#pw} -ge 8 ]] &&
    [[ "$pw" =~ [a-z] ]] &&
    [[ "$pw" =~ [A-Z] ]] &&
    [[ "$pw" =~ [0-9] ]] &&
    [[ "$pw" =~ [[:punct:]] ]]
}

# Basic leetspeak replacement, super tolle Ersetzungen
leetify() {
    echo "$1" | sed -e 's/a/@/Ig' -e 's/e/3/g' -e 's/i/1/g' -e 's/o/0/g' -e 's/s/\$/g' -e 's/t/7/g'
}

# Read each word from file
while IFS= read -r word; do
    [[ -z "$word" ]] && continue
    base=$(capitalize "$word")
    count=0
    attempts=0
    max_attempts=1000
    declare -A used=()

    
    while (( count < max_per_word && attempts < max_attempts )); do
    ((attempts++))
    num="${suffixes[RANDOM % ${#suffixes[@]}]}"
    sym="${symbols[RANDOM % ${#symbols[@]}]}"
    pw="${base}${num}${sym}"

    if [[ -n "${used[$pw]}" ]]; then
        continue
    fi

    if is_complex "$pw"; then
        echo "$pw" >> "$OUTPUT_FILE"
        used["$pw"]=1
        ((count++))
    fi
    done


    # Generate leet variants if enabled, schreib schön die Zahlen da rein
    if $enable_leet; then
        for key in "${!used[@]}"; do
            leet_pw=$(leetify "$key")
            if [[ -z "${used[$leet_pw]}" && "$leet_pw" != "$key" ]]; then
                if is_complex "$leet_pw"; then
                    echo "$leet_pw" >> "$OUTPUT_FILE"
                    used["$leet_pw"]=1
                fi
            fi
        done
    fi

done < "$INPUT_FILE"

echo "Fertig! Output saved in '$OUTPUT_FILE'."
