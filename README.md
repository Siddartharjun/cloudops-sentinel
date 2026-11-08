# CloudOps Sentinel

### AI-Assisted Cloud Operations Incident Assistant

CloudOps Sentinel is a hands-on infrastructure monitoring and incident-detection project built using Linux and Bash scripting.

The project monitors essential Linux system resources, evaluates configurable health thresholds, identifies abnormal conditions and records timestamped alerts for troubleshooting.

**Project status:** Phase 1 — Linux Monitoring and Alert Logging

## Project Objectives

- Monitor Linux infrastructure health.
- Identify disk, CPU and memory utilization issues.
- Classify system conditions as OK, WARNING or CRITICAL.
- Generate timestamped incident alerts.
- Maintain a version-controlled development workflow.

## Current Features

| Feature | Description |
|---|---|
| Disk monitoring | Checks root filesystem utilization |
| CPU monitoring | Calculates CPU utilization using `/proc/stat` |
| Memory monitoring | Calculates memory utilization using `/proc/meminfo` |
| Threshold evaluation | Classifies resource health |
| Alert logging | Records timestamped WARNING and CRITICAL events |
| Git integration | Tracks project changes and commits |

## Technology Stack

- Operating System: Ubuntu 24.04 LTS
- Scripting: Bash
- Version Control: Git
- Repository Hosting: GitHub
- Virtualization: Oracle VirtualBox
- Development Environment: Windows 11 and PowerShell SSH

## Monitoring Thresholds

### Disk

- OK: Below 80%
- WARNING: 80–89%
- CRITICAL: 90% and above

### CPU

- OK: Below 70%
- WARNING: 70–85%
- CRITICAL: Above 85%

### Memory

- OK: Below 80%
- WARNING: 80–89%
- CRITICAL: 90% and above

## Project Structure

```text
cloudops-sentinel/
├── scripts/
│   └── health_check.sh
├── logs/
│   └── alerts.log
├── .gitignore
└── README.md
```

Generated log files are excluded from Git tracking.

## Installation and Usage

Clone the repository:

```bash
git clone https://github.com/Siddartharjun/cloudops-sentinel.git
```

Navigate to the project:

```bash
cd cloudops-sentinel
```

Make the script executable:

```bash
chmod +x scripts/health_check.sh
```

Run the health check:

```bash
./scripts/health_check.sh
```

View generated alerts:

```bash
cat logs/alerts.log
```

## Incident Alert Examples

```text
2026-11-08 15:55:18 | WARNING | Root disk usage reached 85%
2026-11-08 15:55:18 | CRITICAL | Root disk usage reached 95%
```

These examples represent simulated threshold tests.

## Development Roadmap

- [x] Linux environment setup
- [x] Initial Bash health-check script
- [x] Disk utilization monitoring
- [x] CPU utilization monitoring
- [x] Memory utilization monitoring
- [x] Threshold-based health classification
- [x] Timestamped incident alert logging
- [x] Git and GitHub integration
- [ ] Prometheus monitoring integration
- [ ] Node Exporter integration
- [ ] Grafana dashboards
- [ ] Automated alerting and incident runbooks
- [ ] AI-assisted incident analysis
- [ ] Terraform infrastructure automation
- [ ] GitHub Actions CI/CD integration
- [ ] Hybrid cloud extension using AWS

## Future Vision

CloudOps Sentinel aims to evolve into an AI-assisted cloud operations platform that combines infrastructure monitoring, incident detection, observability and intelligent troubleshooting recommendations.

The long-term objective is to help infrastructure engineers identify operational issues faster and make informed troubleshooting decisions.

## Disclaimer

This is a personal learning and portfolio project. It is not connected to any employer's production infrastructure.

---

**Built as a hands-on CloudOps and AIops learning project.**
