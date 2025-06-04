# ora_validate Repository Documentation

This document explains the contents and purpose of all main files in the `drmoutlook/ora_validate` repository.

---

## Root-Level Files

### README.md
Minimal file introducing the repository.

### Template.json
A starter JSON structure with placeholders for:
- Server
- Cluster
- Databases
- Listeners
- OEM AGENT
- Patches

**Purpose:** Used as a template for storing system and Oracle validation results.

### ora_validate.conf
Shell configuration file that sets environment variables, file paths, and command references for validation scripts.

**Purpose:** Centralizes configuration for file locations and key commands.

### ora_validate.lib
Shell script containing reusable functions for:
- Logging and output formatting
- Managing the JSON template file
- Gathering and comparing system and Oracle database information (hostname, kernel, memory, CPU, disks, etc.)
- Executing SQL commands and processing their output
- Backing up Oracle config files
- Modifying JSON files

**Purpose:** Implements the main logic for validating Oracle environments, collecting system/database information, and comparing before/after maintenance results.

### ora_validate.sh
Main shell script to perform Oracle service validation.
- Loads configuration and function library
- Prepares directories for logs, JSON, and backups
- Orchestrates validation and data collection
- Supports comparison mode for pre/post maintenance checks
- Produces log and JSON output summarizing validation

**Purpose:** Entry point for users to validate Oracle environments and compare states before and after maintenance.

---

## `cmd/` Directory

Contains helper scripts called by the main process to collect specific metrics:

- **ora_validate_CPU.sh:** Collects CPU information
- **ora_validate_disks.sh:** Collects disk information
- **ora_validate_memory.sh:** Collects memory information
- **ora_validate_network.sh:** Collects network information
- **ora_validate_oem_agent.sh:** Collects Oracle Enterprise Manager agent information
- **ora_validate_patches.sh:** Collects patch information
- **ora_validate_uptime.sh:** Collects system uptime

**Purpose:** Modularize the collection of system and Oracle-specific metrics.

---

## Summary

The `ora_validate` project is a modular, shell-based toolkit for validating and comparing Oracle environments.  
- Uses configuration and library files for flexibility and maintainability.
- Outputs JSON for easy comparison of system/database state before and after maintenance.
- Helper scripts keep metric-gathering modular and maintainable.

This structure ensures reliable, repeatable validation for Oracle services during patching or maintenance operations.
