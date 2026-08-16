#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$1" == "--help" ]; then
  echo "Usage: bash analyzer.sh <logfile>"
  echo ""
  echo "Options:"
  echo "  --help          Show this help message"
  echo "  <logfile>       Analyze the specified log file"
  echo ""
  echo "Example: bash analyzer.sh sample.log"
  exit 0
fi

if [ -z "$1" ]; then
  echo "Usage: bash analyzer.sh <logfile>"
  echo "Example: bash analyzer.sh sample.log"
  exit 1
fi

log_file="$1"

if [ ! -f "$log_file" ]; then
  echo -e "${RED}ERROR: File '$log_file' not found.${NC}"
  exit 1
fi

report_file="report_$(date +%Y-%m-%d_%H-%M-%S).txt"

{
  echo "----- Log File Analyzer -----"
  echo "Analyzing: $log_file"
  echo "Report generated: $(date)"
  echo ""

  error_count=$(grep -c "ERROR" "$log_file")
  warning_count=$(grep -c "WARNING" "$log_file")
  info_count=$(grep -c "INFO" "$log_file")

  echo "Total lines: $(wc -l < "$log_file")"
  echo "ERROR count: $error_count"
  echo "WARNING count: $warning_count"
  echo "INFO count: $info_count"

  echo ""
  echo "----- Most Common ERROR Messages -----"
  grep "ERROR" "$log_file" | sed 's/^.*ERROR //' | sort | uniq -c | sort -rn | head -5

  echo ""
  echo "----- Error Spike Check -----"
  if [ "$error_count" -ge 3 ]; then
    echo "WARNING: $error_count errors found - possible incident, review needed."
  else
    echo "Error count normal ($error_count errors)."
  fi
} | tee "$report_file"

echo ""
echo "Report saved to: $report_file"
