# log-analyzer

A Bash CLI tool that scans log files and summarizes error/warning/info counts, including the most common recurring error messages.

## What it does
- Counts total lines in a log file
- Counts ERROR, WARNING, and INFO entries
- Shows the top 5 most common ERROR messages
- Works with any log file, not just a fixed one

## How to run
bash analyzer.sh <logfile>

Example:
bash analyzer.sh sample.log

## Why I built this
Practicing log analysis and pattern matching with grep, sed, sort, and uniq - core skills for debugging and DevOps troubleshooting.
