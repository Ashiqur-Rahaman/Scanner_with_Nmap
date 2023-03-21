#!/bin/bash

# Default values
scan_type="basic"      # type of scanning to perform (basic or depth)
target=""              # IP address or hostname of the target system
port=""                # comma-separated list of ports to scan
output_file=""         # path to the output file to write scan results to
verbose=0              # flag to enable verbose output
timing=""              # timing template to use (0-5)

# Function to display help
function show_help {
  echo "Usage: $0 [OPTIONS] TARGET"
  echo "Options:"
  echo "  -b      [Mode] Basic scanning (default)"
  echo "  -d      [Mode] Depth scanning"
  echo "  -h      Show help"
  echo "  -p      Port(s) to scan (comma-separated)"
  echo "  -o      Output file to write scan results to"
  echo "  -v      Verbose output"
  echo "  -T      Timing template to use (0-5)"
  echo "Example: ./scan.sh -b 127.0.0.1 -p 80 -vv -o tr.txt -T 4"
}

# Parse command-line options
while getopts "b:d:hp:o:vT:" opt; do
  case $opt in
    b)
      scan_type="basic"
      target="$OPTARG"
      ;;
    d)
      scan_type="depth"
      target="$OPTARG"
      ;;
    h)
      show_help
      exit 0
      ;;
    p)
      port="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    v)
      verbose=1
      ;;
    T)
      timing="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      show_help
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      show_help
      exit 1
      ;;
  esac
done

# Remove the options that have already been processed
shift $((OPTIND-1))

# Check if target is specified
if [ -z "$target" ]; then
  echo "Target is required." >&2
  show_help
  exit 1
fi

# Build the nmap command
nmap_cmd="nmap"

# Add port option if specified
if [ -n "$port" ]; then
  nmap_cmd="$nmap_cmd -p $port"
fi

# Add output file option if specified
if [ -n "$output_file" ]; then
  nmap_cmd="$nmap_cmd -oN $output_file"
fi

# Add verbose option if specified
if [ "$verbose" -eq 1 ]; then
  nmap_cmd="$nmap_cmd -v"
fi

# Add timing option if specified
if [ -n "$timing" ]; then
  nmap_cmd="$nmap_cmd -T$timing"
fi

# Add the target to the nmap command
nmap_cmd="$nmap_cmd -sV -Pn $target"

# Run the appropriate scan
if [ "$scan_type" == "basic" ]; then
  echo "Basic scanning is started for $target..."
  eval "$nmap_cmd"
elif [ "$scan_type" == "depth" ]; then
  echo "Depth scanning is started for $target..."
  sudo $nmap_cmd -O -p- --script=vuln
fi
