# ![Windows 7 Logo](Windows.png) Windows 10 to Windows 7 Transformation Pack 

This transformation pack is a comprehensive collection of tools and resources designed to replicate the classic Windows 7 experience on Windows 10. Built on open-source foundations and highly customizable, it provides a faithful restoration of the Aero UI, classic sounds, branding, and system components.

## ⚠️ Warning

This project is in active development. While designed for stability, system-level modifications carry inherent risks.
- **Backup:** Create a full system backup before proceeding.
- **Use at your own risk:** The authors are not responsible for system instability or data loss.
- **Licensing:** Some components (e.g., StartIsBack++) are proprietary and may require separate licenses.

## ⚙️ Requirements
- **OS:** Windows 10 version 22H2 (Build 19045).
- **Privileges:** Administrator rights are required for all installation steps.
- **Policy:** PowerShell execution policy must be set to `RemoteSigned` or `Unrestricted`.
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```
- **Optional:** A Windows 7 ISO (en-US) is required if you choose to install **Explorer7**.

## 📦 Installation

The unified installer provides a streamlined, automated setup process with built-in safety checks and backups.

### Automated Setup (Recommended)
1. **Extract** the pack to a short path (e.g., `C:\Win7Pack`).
2. **Open PowerShell as Administrator** and navigate to the folder.
3. **Run the installer:**
   ```powershell
   .\install.ps1
   ```
4. **Follow the interactive menu** to select your desired components.

### Command-Line Options
| Command | Description |
|---|---|
| `.\install.ps1 -All` | Install all components (interactive confirmation). |
| `.\install.ps1 -All -Silent` | Fully automated installation of all components. |
| `.\install.ps1 -Components "Theme,Sounds"` | Install specific components silently. |
| `.\install.ps1 -WhatIf -All` | Preview changes without applying them. |
| `.\install.ps1 -NoRestorePoint` | Skip system restore point creation (not recommended). |

---

## 🛠️ Component Overview

The following components are included in the pack and can be managed via the unified installer.

### Core Theming
*   **SecureUxTheme:** The foundation for custom theme support.
*   **Aero10 Theme:** 30 high-quality variants (Seven, Vista, Metro styles) in 6 accent colors.
*   **DWMBlurGlass:** Restores native-like transparent title bars (Aero Glass).
*   **Branding & Logos:** Windows 7 logos and system branding.
*   **Cursors & User Tiles:** Classic cursor scheme and account pictures.

### System Interface
*   **Windhawk:** A powerful modding platform. Includes the **Resource Redirect** mod for icon and resource replacement.
*   **AuthUX:** A faithful restoration of the Windows 7 logon screen.
*   **Classic UAC:** Restores the non-XAML User Account Control dialog.
*   **OpenWithEx:** An improved, classic-style "Open With" dialog.

### Control Panel & Shell
*   **CPL Restoration:** Restores 21 classic Control Panel pages (e.g., Windows Update, Network Map, Personalization links).
*   **HomeGroup Restoration:** Restores HomeGroup functionality (removed in Win10 1803).
*   **Default Programs Fix:** Resolves dead links in the modern settings app to point to classic applets.

### Apps & Games
*   **Windows 7 Games:** Classic games including Solitaire, Minesweeper, and Mahjong.
*   **Winaero Tweaker:** Essential tool for fine-tuning legacy behavior.
*   **Sounds:** The complete Windows 7 sound scheme.

### Advanced Options
*   **Start Menu:** Choose between **Explorer7** (native Win7 shell, experimental) or **StartIsBack++** (highly stable, paid).
*   **HackBGRT:** Custom UEFI boot logo. **Requires Secure Boot to be disabled.**

---

## ❓ Troubleshooting & Rollback

### Common Issues
- **Theme not applying:** Ensure SecureUxTheme is installed and you have rebooted.
- **Windhawk mods:** Open the Windhawk UI to verify "Resource Redirect" is active and pointed to `C:\Windows\ResourceRedirect\theme.ini`.
- **UWP Apps:** Explorer7 may impact UWP app stability. Use StartIsBack++ for better compatibility.

### Uninstallation
1. **System Restore:** Use the restore point created by the installer.
2. **Manual Rollback:** Use `Rollback.ps1` (if available) or manually uninstall components via Settings > Apps.
3. **Backups:** Original system files are backed up to the `Backup\` directory within the pack.

---

## 🙏 Credits & Resources
This project aggregates the work of the incredible Windows customization community:
- **Windhawk:** RamenSoftware
- **Explorer7 & AuthUX:** World Windows Federation
- **Aero10 Theme:** vaporvance
- **CPL Restoration:** WinClassic Community
- **SecureUxTheme:** namazso
- **Resource Hacker:** Angus Johnson
- **PowerRun:** Sordum
