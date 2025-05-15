#!/bin/bash

sites=("https://www.facebook.com" "https://www.twitter.com" "https://www.instagram.com" "https://www.tiktok.com")
log_file="server_status.log"

echo "Checking social media status..."
for site in "${sites[@]}"; do
    status_code=$(curl -s -o /dev/null -w "%{http_code}" "$site")
    
    if [[ "$status_code" -ge 200 && "$status_code" -lt 400 ]]; then
        echo "$(date): $site is UP" | tee -a "$log_file"
    else
        echo "$(date): $site is DOWN!" | tee -a "$log_file"
        # Example notification (Linux)
        notify-send "Alert: $site seems down!"
    fi
done
