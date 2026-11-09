# Runbook: High Disk Utilization

## 1. Alert Information

Alert Name: CloudOps - Root Disk Usage High
Metric: Root Filesystem Utilization
Warning Threshold: Above 80%
Evaluation Interval: 1 minute
Pending Period: 1 minute

## 2. Symptoms

- Root filesystem utilization is high.
- Available disk space is decreasing.
- Applications may fail to write files.
- Grafana disk alert transitions to Firing.

## 3. Investigation Steps

### Check filesystem utilization

df -h /

### Identify large directories

sudo du -xhd1 / 2>/dev/null | sort -h

### Investigate log directory

sudo du -h -d1 /var/log 2>/dev/null | sort -h

### Check journal storage

sudo journalctl --disk-usage

### Investigate package cache

sudo du -sh /var/cache/apt

### Find large files

sudo find /var -xdev -type f -size +100M -exec ls -lh {} \;

## 4. Possible Root Causes

- Growing application logs.
- System journal accumulation.
- Package cache accumulation.
- Large application data files.
- Temporary files and backups.

## 5. Remediation

1. Identify the filesystem and directory consuming space.
2. Inspect large files before taking action.
3. Check log retention requirements.
4. Use approved journal retention policies.
5. Clean package caches when appropriate.
6. Never delete unknown application or system files.

## 6. Recovery Verification

Run:

df -h /

Check Grafana:
- Root disk alert should return to Normal.
- Filesystem utilization should fall below 80%.

Check webhook logs:

tail -n 20 logs/webhook.log

## 7. Escalation

If disk utilization remains high:
- Capture filesystem usage.
- Identify large files and directories.
- Record investigation findings.
- Escalate to the application or infrastructure team.

## 8. Evidence

Record:
- Alert firing time
- Peak disk utilization
- Filesystem affected
- Largest directories
- Cleanup performed
- Space recovered
- Recovery time
