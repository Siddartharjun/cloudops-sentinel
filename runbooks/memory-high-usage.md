# Runbook: High Memory Utilization

## 1. Alert Information

Alert Name: CloudOps - Memory Usage High
Metric: Memory Utilization
Threshold: Above 80%
Evaluation Interval: 1 minute
Pending Period: 1 minute

## 2. Symptoms

- High RAM utilization.
- Low available memory.
- Applications responding slowly.
- Memory alert transitions to Firing.

## 3. Investigation Steps

### Check memory utilization

free -h

### Inspect memory details

cat /proc/meminfo

### Identify memory-intensive processes

ps aux --sort=-%mem | head -10

### Check system activity

top

### Check swap utilization

swapon --show

## 4. Possible Root Causes

- Memory-intensive applications.
- Memory leaks.
- Excessive concurrent processes.
- Background jobs consuming RAM.

## 5. Remediation

1. Identify the process consuming excessive memory.
2. Check whether the process is expected.
3. Review application logs.
4. Contact the application owner if necessary.
5. Restart or stop processes only with authorization.

Avoid killing critical processes without investigation.

## 6. Recovery Verification

Run:

free -h

Check Grafana:
- Memory alert should return to Normal.
- Memory utilization should fall below 80%.

Check webhook logs:

tail -n 20 logs/webhook.log

## 7. Escalation

If memory remains high:
- Capture process information.
- Collect relevant logs.
- Record incident timestamps.
- Escalate to the application or infrastructure team.

## 8. Evidence

Record:
- Alert firing time
- Peak memory utilization
- Process responsible
- Investigation findings
- Remediation performed
- Recovery time
