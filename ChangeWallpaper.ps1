# ChangeWallpaper.ps1

# Define your wallpaper paths
$lightWallpaper = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
$darkWallpaper  = "C:\Windows\Web\Wallpaper\Windows\img19.jpg"

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# --- Determine expected wallpaper based on time ---
$hour = (Get-Date).Hour
if ($hour -ge 7 -and $hour -lt 18) {
    $expectedWallpaper = $lightWallpaper
} else {
    $expectedWallpaper = $darkWallpaper
}

# --- Check current wallpaper state ---
$wallpaperRegPath = "HKCU:\Control Panel\Desktop"
$currentWallpaper = (Get-ItemProperty -Path $wallpaperRegPath).WallPaper

# SPI_SETDESKWALLPAPER = 20
# SPIF_UPDATEINIFILE = 0x01
# SPIF_SENDCHANGE = 0x02
if ($currentWallpaper -ne $expectedWallpaper) {
    Write-Output "Wallpaper mismatch. Updating to $expectedWallpaper..."
    [Wallpaper]::SystemParametersInfo(20, 0, $expectedWallpaper, 0x01 -bor 0x02)
} else {
    Write-Output "Wallpaper already set correctly ($expectedWallpaper)."
}