# Cài devt CLI trên Windows.
# Dùng: irm https://your-domain/install.ps1 | iex
$ErrorActionPreference = "Stop"

$Repo = "son-lhs/devt-releases"   # Repo PUBLIC chỉ chứa file cài đặt — source code nằm ở repo private khác
$InstallDir = "$env:LOCALAPPDATA\devt"
$BinName = "devt.exe"

$Arch = if ([Environment]::Is64BitOperatingSystem) {
    if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "amd64" }
} else {
    "amd64"
}

$Asset = "devt-windows-$Arch.exe"
$Url = "https://github.com/$Repo/releases/latest/download/$Asset"

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

Write-Host "📦 Đang tải $Asset..."
Invoke-WebRequest -Uri $Url -OutFile "$InstallDir\$BinName"

# Thêm vào PATH của user nếu chưa có
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$InstallDir", "User")
    Write-Host "🔧 Đã thêm $InstallDir vào PATH. Mở lại terminal để dùng lệnh 'devt'."
}

Write-Host "✅ Đã cài xong tại $InstallDir\$BinName"
& "$InstallDir\$BinName" version
