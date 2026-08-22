# log-analyzer

A Bash CLI tool that scans one or more log files and summarizes error/warning/info counts, identifies the most common recurring error messages, flags possible incidents, and generates reports in both text and HTML format.

## Features
- Analyze a single log file or multiple at once
- Counts ERROR, WARNING, and INFO entries per file
- Shows top 5 most common ERROR messages per file
- Combined summary totals across all files analyzed
- Flags possible incidents when error count is high
- Keyword search across log files with --search
- Saves a timestamped text report for every run
- Generates a visual HTML report you can open in a browser
- Color-coded terminal output
- --help flag for usage instructions

## How to run
bash analyzer.sh <logfile>
bash analyzer.sh <logfile1> <logfile2> <logfile3>
bash analyzer.sh --search <keyword> <logfile>

Examples:
bash analyzer.sh sample.log
bash analyzer.sh sample.log sample2.log
bash analyzer.sh --search "connection" sample.log

## Why I built this
Practicing log analysis and pattern matching with grep, sed, sort, and uniq - core skills for debugging and DevOps troubleshooting. Extended to support multiple files, keyword search, and visual HTML reporting to simulate real-world log monitoring workflows.
