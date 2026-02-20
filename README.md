# log_parser_v1.sh Documentation

## Overview
The `log_parser` script is designed to parse and analyze log files from dynamic trace data sources. It provides insights into service errors on the Linux server.

## Configuration
To configure the script, you'll need to specify the following parameters:
- `LOG_DIR` - The path to the log file that needs to be parsed.
- `LOG_FILE` - The file where the parsing results will be written.
- `HOST_IP` - The host ip of the source.
- `URL` - Dynatrace tenant URL with environment ID.
- `Access Token` - Access Token with Ingest.Metric permission.
- `Keywords` - Array of keywords to match the log entries.
- `Metric Name` - Metric name to be configured in the payload (recommended format: custom.app_name...)

Ensure that the configuration values follow the required format to avoid issues during execution.

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/Mohammed-Aftab-Siddique/dynatrace-log-parser.git
   ```
2. Navigate to the cloned directory:
   ```bash
   cd dynatrace-log-parser
   ```
3. Ensure that you have the necessary permissions to execute the script:
   ```bash
   chmod +x log_parser_v1.sh
   ```
## Metric Overview
Metric Name:
 ```bash
   custom.log.error
   ```
Metric Dimensions:
 ```bash
   host, dir & service
   ```
Metric Value:
 ```bash
   status
   ```
## Security Considerations
- Be aware of the sensitivity of the log data being processed. Avoid exposing sensitive information in the output files.
- Run the script in a secure environment to prevent unauthorized access to the log files.

## Troubleshooting
- **Error: "Log file not found"**: Ensure that the `LOG_FILE` path is correct.
- **Permission Denied**: Check that the script has appropriate execution permissions.

## Examples
To run the parser on a log file, use the following command:
```bash
./log_parser_v1.sh
```

This command will process the specified log file and ingest an output to dynatrace.

## Sample Output
<img width="1944" height="1076" alt="image" src="https://github.com/user-attachments/assets/b4b49dac-f942-44e6-9aec-01cf1c70aed4" />

# Version History

# log_parser_v2
- Updated the logic to fetch the latest log file.
  - Added a check to use `ls` if the file count is less than `ARG_MAX` otherwise use `find`.
  - This avoids the failure due to `Too Many Arguments`.

## log_parser_v1
- Initial Release

