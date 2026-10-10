# Antivirus Daemon & Interactive Restore Tool

A simple Bash antivirus daemon that monitors a folder for file changes, quarantines suspicious files, and provides an interactive script to restore or delete them.

## 1. Project Overview & Folder Structure

- `antivirusd.sh`: Background script monitoring the watch directory and quarantining malicious files.
- `restore.sh`: Interactive CLI tool to inspect, restore, or delete quarantined files.
- `Makefile`: Automates setup, running the scripts, and cleaning up log files.
- `README.md`: Documentation for the project.

Folder layout:
cc373-lab2/
├── antivirusd.sh
├── restore.sh
├── Makefile
└── README.md

## 2. Prerequisites & Setup

Tested on Ubuntu Linux with standard shell utilities (`bash`, `make`, `diff`, `cmp`).

Install `make` if it is not already installed:
sudo apt update
sudo apt install make

Ensure scripts have execute permissions:
chmod +x antivirusd.sh restore.sh

## 3. How to Run

### Using Makefile
- Run the antivirus daemon:
  make run
- Run the restore tool:
  make restore
- Clean snapshot tracking files:
  make clean

### Running Manually
- Antivirus daemon:
  ./antivirusd.sh <watch_dir> <quarantine_dir> <interval_seconds>
- Restore tool:
  ./restore.sh <watch_dir> <quarantine_dir>

## 4. Flagged Lists Definition

The detection rules are hardcoded inside `antivirusd.sh`:
- Flagged extensions: `.exe`, `.bat`, `.vbs`, `.scr`, `.ps1`
- Flagged keywords: `virus`, `trojan`, `malware`, `worm`, `ransomware` (checked case-insensitively using `grep -i`)
