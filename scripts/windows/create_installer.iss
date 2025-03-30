[Setup]
AppName=Medical Office
AppVersion=1.0
DefaultDirName={pf}\MedicalOfficeInstaller
DefaultGroupName=Medical Office
UninstallDisplayIcon={app}\MedicalOfficeInstaller.exe
OutputDir=installer_output
OutputBaseFilename=MedicalOfficeInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "installer_output\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Medical Office"; Filename: "{app}\wrapper.ps1"

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File \"{app}\wrapper.ps1\""; WorkingDir: "{app}"; StatusMsg: "Starting Medical Office..."
