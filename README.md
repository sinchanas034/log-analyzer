# log-analyzer

A Bash CLI tool that scans one or more log files and summarizes error/warning/info counts, identifies the most common recurring error messages, flags possible incidents, and generates timestamped reports.

## Features
- Analyze a single log file or multiple at once
- Counts ERROR, WARNING, and INFO entries per file
- Shows top 5 most common ERROR messages per file
- Combined summary totals across all files analyzed
- Flags possible incidents when error count is high
- Saves a timestamped report file for every run
- Color-coded terminal output
- --help flag for usage instructions

## How to run
bash analyzer.sh <logfile>
bash analyzer.sh <logfile1> <logfile2> <logfile3>

Examples:
bash analyzer.sh sample.log
bash analyzer.sh sample.log sample2.log

## Why I built this
Practicing log analysis and pattern matching with grep, sed, sort, and uniq - core skills for debugging and DevOps troubleshooting. Extended to support multiple files to simulate real-world scenarios where several log sources need to be reviewed together.
