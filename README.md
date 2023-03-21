# Simple_scanner_with_Nmap
This is a simple Bash script for performing basic or depth network scans on a target system using the Nmap network exploration tool.

To use the script, simply execute it from the command line with the following command:

bash

./Scanner.sh [OPTIONS] TARGET

Where OPTIONS are one or more of the following command-line options:

    -b: Basic scanning (default)
    -d: Depth scanning
    -h: Show help
    -p: Port(s) to scan (comma-separated)
    -o: Output file to write scan results to
    -v: Verbose output
    -T: Timing template to use (0-5)

And TARGET is the IP address or hostname of the target system to scan.
Example

To perform a basic scan on the target system at IP address 192.168.1.1 and output the results to a file named scan_results.txt, run the following command:

bash

./Scanner.sh -p 22,80,443 -o scan_results.txt 192.168.1.1

Requirements

Run the Requirement.sh to make sure all required tools are installed.



License

This script is released under the MIT License. Feel free to modify and distribute it as you see fit.
