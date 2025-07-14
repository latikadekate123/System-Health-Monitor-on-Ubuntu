# System Health Monitor on Ubuntu

This is a basic System Health Monitoring Tool built entirely with **pure Bash**. It checks essential system stats like **disk usage, memory load, CPU load, and uptime**, and provides real-time **desktop notifications** and **sound alerts** whenever the script is run.

It’s a simple yet effective way to stay informed about your system’s health — whether you’re running it manually or setting it up as a scheduled task.

##  Features

**- Monitors:**
  - Disk usage (with threshold warning)
  - Memory usage
  - CPU 1-min load average
  - System uptime

**- Alerts:**
  - Desktop pop-up notifications using `notify-send`
  - Sound alerts via `paplay` to catch your attention
  
**- Logging:**
  - Every run logs detailed output to `system_health_log.txt`
  - Includes timestamped summaries for historical tracking
