#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: bash analyzer.sh <logfile>"
  echo "Example: bash analyzer.sh sample.log"
  exit 1
fi

log_file="$1"

if [ ! -f "$log_file" ]; then
  echo "ERROR: File '$log_file' not found."
  exit 1
fi

echo "----- Log File Analyzer -----"
echo "Analyzing: $log_file"
echo ""

echo "Total lines: $(wc -l < "$log_file")"
echo "ERROR count: $(grep -c "ERROR" "$log_file")"
echo "WARNING count: $(grep -c "WARNING" "$log_file")"
echo "INFO count: $(grep -c "INFO" "$log_file")"

echo ""
echo "----- Most Common ERROR Messages -----"
grep "ERROR" "$log_file" | sed 's/^.*ERROR //' | sort | uniq -c | sort -rn | head -5

echo ""
echo "----- Error Spike Check -----"
error_count=$(grep -c "ERROR" "$log_file")
if [ "$error_count" -ge 3 ]; then
  echo "WARNING: $error_count errors found - possible incident, review needed."
else
  echo "Error count normal ($error_count errors)."
fi
