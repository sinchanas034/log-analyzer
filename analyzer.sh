#!/bin/bash
echo "----- Log File Analyzer -----"

log_file="sample.log"

echo "Total lines: $(wc -l < "$log_file")"
echo "ERROR count: $(grep -c "ERROR" "$log_file")"
echo "WARNING count: $(grep -c "WARNING" "$log_file")"
echo "INFO count: $(grep -c "INFO" "$log_file")"

echo ""
echo "----- Most Common ERROR Messages -----"
grep "ERROR" "$log_file" | sed 's/^.*ERROR //' | sort | uniq -c | sort -rn | head -5
