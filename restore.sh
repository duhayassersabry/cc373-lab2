#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <dir> <malicious_dir>"
	exit 1
fi

DIR="$1"
MALICIOUS_DIR="$2"

files=("$MALICIOUS_DIR"/*)

if [ ! -e "${files[0]}" ]; then
	echo "No malicious files to review."
	exit 0
fi	

while true; do
	files=("$MALICIOUS_DIR"/*)
	if [ ! -e "${files[0]}" ]; then
		echo "No malicious files to review."
		exit 0
	fi
	echo ""
	echo "Files in quarantine:"

	for i  in "${!files[@]}"; do
		display_num=$((i+1))
		file_name=$(basename "${files[$i]}")
		echo "$display_num) $file_name"
	done

	read -p "Select a file by number (or q for quit):" choice
	if [ "$choice" = "q" ]; then
		break	
	fi

	idx=$((choice-1))
	selected_path="${files[$idx]}"

	if [ -z "$selected_path" ] || [ ! -e "$selected_path" ]; then
		echo "Invalid option. Please try again."
		continue
	fi

	selected_name=$(basename "$selected_path")

	echo ""
	echo "Options for $selected_name:"
	echo "1) Restore this file back to $DIR"
	echo "2) Permanently delete this file"
	echo "3) Leave this file as-is and return to list"

	read -p "Enter choice [1-3]:" action

	case "$action" in
		1)
			echo "$selected_name">> .whitelist
			mv "$selected_path" "$DIR/"
			echo "Restored $selected_name to $DIR."
			;;
		2) 
			rm "$selected_path"
			echo "$selected_name permanently deleted."
			;;
		3)
			;;
		*)
			echo "Invalid option."
			;;
	esac
done
		
