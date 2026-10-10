#!/bin/bash

DIR="$1"
MALICIOUS_DIR="$2"
INTERVAL="$3"

FLAGGED_EXTS=("exe" "bat" "vbs" "scr" "ps1")
FLAGGED_WORDS=("virus" "trojan" "malware" "worm" "ransomware")

mkdir -p "$MALICIOUS_DIR"

scan_directory(){
	for filepath in "$DIR"/*; do
		[ -f "$filepath" ] || continue
		
		filename=$(basename "$filepath")
		is_malicious=false
		
		for ext in "${FLAGGED_EXTS[@]}"; do
			if [[ "$filename" == *.${ext} ]]; then
				is_malicious=true
				break
			fi
		done 
		
		if [[ "$is_malicious" == "false" ]]; then
			for word in "${FLAGGED_WORDS[@]}"; do
				if grep -qi "$word" "$filepath"; then
					is_malicious=true
					break
				fi
			done 
		fi
		
		if [[ "$is_malicious" == "true" ]]; then
			echo "$filename is malicious and it is DELETED"
			cp "$filepath" "$MALICIOUS_DIR/"
			rm "$filepath"
		fi	
		
	done

}

scan_directory
ls -l "$DIR" > directory-info.last

while true; do
	sleep "$INTERVAL"
	ls -l "$DIR" > directory-info.new
	
	if ! cmp -s directory-info.last directory-info.new; then
		scan_directory
		ls -l "$DIR" > directory-info.last
	fi
done
