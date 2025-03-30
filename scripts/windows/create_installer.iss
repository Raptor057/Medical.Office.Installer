# scripts/windows/create_installer.iss (archivo Inno Setup Script)

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
Name: "{group}\Medical Office"; Filename: "{app}\start_windows.ps1"

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File \"{app}\start_windows.ps1\""; WorkingDir: "{app}"; StatusMsg: "Starting Medical Office..."

[Code]
function InitializeSetup(): Boolean;
begin
  Result := True;
end;
