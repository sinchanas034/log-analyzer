#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$1" == "--help" ]; then
  echo "Usage: bash analyzer.sh <logfile1> [logfile2] [logfile3] ..."
  echo ""
  echo "Options:"
  echo "  --help          Show this help message"
  echo "  <logfile>       Analyze one or more specified log files"
  echo ""
  echo "Example: bash analyzer.sh sample.log sample2.log"
  exit 0
fi

if [ -z "$1" ]; then
  echo "Usage: bash analyzer.sh <logfile1> [logfile2] ..."
  echo "Example: bash analyzer.sh sample.log"
  exit 1
fi

search_term=""
if [ "$1" == "--search" ]; then
  search_term="$2"
  shift 2
  if [ -z "$search_term" ]; then
    echo "ERROR: --search requires a keyword. Example: bash analyzer.sh --search timeout sample.log"
    exit 1
  fi
fi

report_file="report_$(date +%Y-%m-%d_%H-%M-%S).txt"
total_errors=0
total_warnings=0
total_info=0

{
  echo "----- Log File Analyzer -----"
  echo "Report generated: $(date)"

  for log_file in "$@"; do
    if [ ! -f "$log_file" ]; then
      echo ""
      echo "ERROR: File '$log_file' not found. Skipping."
      continue
    fi

    error_count=$(grep -c "ERROR" "$log_file")
    warning_count=$(grep -c "WARNING" "$log_file")
    info_count=$(grep -c "INFO" "$log_file")

    total_errors=$((total_errors + error_count))
    total_warnings=$((total_warnings + warning_count))
    total_info=$((total_info + info_count))

    echo ""
    echo "===== $log_file ====="
    echo "Total lines: $(wc -l < "$log_file")"
    echo "ERROR count: $error_count"
    echo "WARNING count: $warning_count"
    echo "INFO count: $info_count"
    echo ""
    echo "Most Common ERROR Messages:"
    grep "ERROR" "$log_file" | sed 's/^.*ERROR //' | sort | uniq -c | sort -rn | head -5

    if [ -n "$search_term" ]; then
      echo ""
      echo "Lines matching '$search_term':"
      grep -i "$search_term" "$log_file" || echo "  (no matches found)"
    fi
  done

  echo ""
  echo "===== COMBINED SUMMARY ====="
  echo "Total ERROR count across all files: $total_errors"
  echo "Total WARNING count across all files: $total_warnings"
  echo "Total INFO count across all files: $total_info"

  echo ""
  echo "----- Error Spike Check -----"
  if [ "$total_errors" -ge 3 ]; then
    echo "WARNING: $total_errors total errors found - possible incident, review needed."
  else
    echo "Error count normal ($total_errors errors)."
  fi
} | tee "$report_file"

echo ""
echo "Report saved to: $report_file"
