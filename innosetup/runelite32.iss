[Setup]
AppName=Areos Launcher
AppPublisher=Areos
UninstallDisplayName=Areos
AppVersion=${project.version}
AppSupportURL=https://areosrsps.com
DefaultDirName={localappdata}\Areos

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Areos.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=AreosSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x86\Areos.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x86\Areos.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x86\launcher_x86.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x86\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x86\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Areos\Areos"; Filename: "{app}\Areos.exe"
Name: "{userprograms}\Areos\Areos (configure)"; Filename: "{app}\Areos.exe"; Parameters: "--configure"
Name: "{userprograms}\Areos\Areos (safe mode)"; Filename: "{app}\Areos.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Areos"; Filename: "{app}\Areos.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Areos.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Areos.exe"; Description: "&Open Areos"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Areos.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.Areos\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Areos.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"