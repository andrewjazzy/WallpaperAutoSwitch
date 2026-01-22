' ChangeWallpaper.vbs
Option Explicit

Dim objShell, strCommand
Set objShell = CreateObject("WScript.Shell")

' Build the PowerShell command
strCommand = "powershell.exe -ExecutionPolicy Bypass -File ""C:\Users\cyber\Documents\WallpaperAutoSwitch\ChangeWallpaper.ps1"""

' Run hidden (0 = hidden, True = wait until finished)
objShell.Run strCommand, 0, True
