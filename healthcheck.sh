#!/bin/bash

REPORT_FILE="/home/ubuntu/health_report.html"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
STYLE="style='font-family:Arial;border-collapse:collapse;width:80%;margin:auto;'"
TH="style='border:1px solid #ddd;padding:8px;background-color:#f2f2f2;'"
TD="style='border:1px solid #ddd;padding:8px;'"

# Start HTML
echo "<html><head><title>System Health Report</title></head><body>" > $REPORT_FILE
echo "<h2 style='text-align:center;'>System Health Report - $TIMESTAMP</h2>" >> $REPORT_FILE

##############################
### SERVER HEALTH SECTION  ###
##############################
echo "<h3 style='text-align:center;'>Server Info</h3>" >> $REPORT_FILE
echo "<table $STYLE>" >> $REPORT_FILE
echo "<tr><th $TH>Hostname</th><td $TD>$(hostname)</td></tr>" >> $REPORT_FILE
echo "<tr><th $TH>IP Address</th><td $TD>$(hostname -I | awk '{print $1}')</td></tr>" >> $REPORT_FILE
echo "<tr><th $TH>Uptime</th><td $TD>$(uptime -p)</td></tr>" >> $REPORT_FILE
echo "<tr><th $TH>CPU Load (1/5/15 min)</th><td $TD>$(uptime | awk -F'load average:' '{print $2}')</td></tr>" >> $REPORT_FILE
echo "<tr><th $TH>Total RAM</th><td $TD>$(free -h | awk '/Mem:/ {print $2}')</td></tr>" >> $REPORT_FILE
echo "<tr><th $TH>Used RAM</th><td $TD>$(free -h | awk '/Mem:/ {print $3}')</td></tr>" >> $REPORT_FILE
echo "<tr><th $TH>Disk Usage</th><td $TD>$(df -h / | awk 'NR==2{print $3 " used of " $2 " (" $5 ")"}')</td></tr>" >> $REPORT_FILE
echo "</table>" >> $REPORT_FILE

##############################
### DOCKER CONTAINER STATUS ###
##############################
echo "<h3 style='text-align:center;'>Docker Container Status</h3>" >> $REPORT_FILE
echo "<table $STYLE><tr><th $TH>Container ID</th><th $TH>Name</th><th $TH>Status</th></tr>" >> $REPORT_FILE
docker ps --format '{{.ID}} {{.Names}} {{.Status}}' | while read line; do
    ID=$(echo $line | awk '{print $1}')
    NAME=$(echo $line | awk '{print $2}')
    STATUS=$(echo $line | cut -d' ' -f3-)
    echo "<tr><td $TD>$ID</td><td $TD>$NAME</td><td $TD>$STATUS</td></tr>" >> $REPORT_FILE
done
echo "</table>" >> $REPORT_FILE

##############################
### K8S POD STATUS ###
##############################
echo "<h3 style='text-align:center;'>Kubernetes Pod Status</h3>" >> $REPORT_FILE
echo "<table $STYLE><tr><th $TH>Pod</th><th $TH>Status</th><th $TH>Restarts</th></tr>" >> $REPORT_FILE
kubectl get pods --no-headers | while read line; do
    POD=$(echo $line | awk '{print $1}')
    STATUS=$(echo $line | awk '{print $3}')
    RESTARTS=$(echo $line | awk '{print $4}')
    echo "<tr><td $TD>$POD</td><td $TD>$STATUS</td><td $TD>$RESTARTS</td></tr>" >> $REPORT_FILE
done
echo "</table>" >> $REPORT_FILE

##############################
### K8S SERVICE STATUS ###
##############################
echo "<h3 style='text-align:center;'>Kubernetes Service Info</h3>" >> $REPORT_FILE
echo "<table $STYLE><tr><th $TH>Name</th><th $TH>Type</th><th $TH>Cluster IP</th><th $TH>Ports</th></tr>" >> $REPORT_FILE
kubectl get svc --no-headers | while read line; do
    NAME=$(echo $line | awk '{print $1}')
    TYPE=$(echo $line | awk '{print $2}')
    CLUSTER_IP=$(echo $line | awk '{print $3}')
    PORTS=$(echo $line | awk '{print $5}')
    echo "<tr><td $TD>$NAME</td><td $TD>$TYPE</td><td $TD>$CLUSTER_IP</td><td $TD>$PORTS</td></tr>" >> $REPORT_FILE
done
echo "</table>" >> $REPORT_FILE

##############################
### APP ACCESS TEST ###
##############################
APP_URL="http://$(minikube ip):30080"
APP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

echo "<h3 style='text-align:center;'>App Accessibility Check</h3>" >> $REPORT_FILE
echo "<p style='text-align:center;'>$APP_URL returned <strong>HTTP $APP_STATUS</strong></p>" >> $REPORT_FILE

# End HTML
echo "</body></html>" >> $REPORT_FILE
