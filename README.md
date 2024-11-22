# ConfigureLaunchAuthPage.ps1

## Overview

The **`ConfigureLaunchAuthPage.ps1`** script is designed to configure a Windows registry key for the Cato Agent and attempt to start the Cato Agent programmatically. It includes robust logging for troubleshooting, capturing registry modifications, and execution details of the Cato Agent startup process.

---

## Features

- Configures the `LaunchAuthPageOnStartup` registry key for seamless user authentication with the Cato Agent.
- Validates and ensures the registry key exists or creates it if necessary.
- Logs all actions, including registry updates, errors, and the status of the Cato Agent startup process.
- Captures debug information for the Cato Client using `Start-Process` with detailed output logged to a file.

---

## Requirements

- **Windows OS** with PowerShell 5.1 or higher.
- Administrative privileges to modify the registry.
- The Cato Agent executable must be installed and located at:
  ```
  C:\Program Files (x86)\Cato Networks\Cato Client\CatoClient.exe
  ```

---

## Script Details

### Versioning

This script uses a versioning system to track updates. The current version is:
- **Version: 7**

### Logging

1. **General Execution Logs**
   - Location: `C:\Logs\RegistryScriptLog.txt`
   - Captures:
     - Registry modifications.
     - Errors or exceptions during the script execution.
     - The status of the Cato Agent startup.

2. **Cato Client Debug Log**
   - Location: `C:\Logs\CatoClientDebugLog.txt`
   - Captures:
     - Detailed output of the `Start-Process` command for the Cato Client.

---

## Usage

### Steps to Execute

1. **Clone or Download the Script**
   ```bash
   git clone <repository-url>
   ```

2. **Open PowerShell as Administrator**
   - Ensure you have administrative privileges to modify the registry.

3. **Run the Script**
   ```powershell
   .\ConfigureLaunchAuthPage.ps1
   ```

4. **Check the Logs**
   - Verify the registry updates and program startup status in the log files:
     - `C:\Logs\RegistryScriptLog.txt`
     - `C:\Logs\CatoClientDebugLog.txt`

---

## Troubleshooting

### Common Issues

1. **Registry Permission Errors**
   - Ensure the script is run as an administrator, as modifying `HKEY_LOCAL_MACHINE` requires elevated permissions.

2. **Cato Agent Not Found**
   - Verify the installation path of the Cato Agent executable. The default path expected by the script is:
     ```
     C:\Program Files (x86)\Cato Networks\Cato Client\CatoClient.exe
     ```
   - Update the `$CatoExePath` variable in the script if the executable is located elsewhere.

3. **Unhandled Exceptions in Cato Client**
   - If the Cato Client throws unhandled exceptions during startup:
     - Verify Azure AD configurations or credentials if applicable.
     - Review `CatoClientDebugLog.txt` for detailed errors.
     - Consult Cato Networks documentation or support.

---

## Development

### Version History

| Version | Date       | Changes                                                         |
|---------|------------|-----------------------------------------------------------------|
| 7       | 2024-11-20 | Added logging for `Start-Process` and enhanced troubleshooting. |
| 6       | 2024-11-19 | Improved error handling for registry operations.               |
| 5       | 2024-11-18 | Added registry key validation and creation logic.              |

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m "Add feature-name"`).
4. Push to the branch (`git push origin feature-name`).
5. Create a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Support

If you encounter any issues, feel free to open an issue in this repository or contact your administrator for assistance.

---
