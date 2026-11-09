# Runbook: High CPU Utilization

## 1. Alert Information

Alert Name: CloudOps - CPU Usage High
Metric: CPU Utilization
Warning Threshold: Above 70%
Evaluation Interval: 1 minute
Pending Period: 1 minute

## 2. Symptoms

- High CPU utilization on the Ubuntu VM.
- Slow application or system response.
- Increased system load average.
- CPU alert transitions to Firing in Grafana.

## 3. Investigation Steps

### Check CPU utilization

top

### Identify CPU-intensive processes

ps aux --sort=-%cpu | head -10

### Check system load

uptime

### Check CPU information

lscpu

### Check process details

ps -ef

## 4. Possible Root Causes

- CPU-intensive application processes.
- Unexpected background jobs.
- Multiple resource-intensive tasks.
- Application malfunction or runaway processes.

## 5. Remediation

1. Identify the process consuming excessive CPU.
2. Verify whether the process is expected.
3. Contact the application owner if necessary.
4. Stop an unwanted process only after authorization.
5. Monitor CPU utilization after remediation.

Avoid killing critical system processes without investigation.

## 6. Recovery Verification

Check CPU utilization again:

top

Check Grafana:
- CPU alert should return to Normal.
- CPU utilization should fall below 70%.

Check webhook logs:

tail -n 20 logs/webhook.log

Verify firing and resolved notifications.

## 7. Escalation

If CPU utilization remains high:
- Capture process information.
- Collect relevant logs.
- Record incident timestamps.
- Escalate to the application or infrastructure team.

## 8. Evidence

Record:
- Alert firing time
- Peak CPU utilization
- Process responsible
- Investigation findings
- Remediation performed
- Recovery time
