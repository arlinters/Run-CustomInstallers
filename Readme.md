## Synopsis

This is a PowerShell script that lets you run installers that are stored on your network. You simply enter in the path for the installer or a batch script, the display name you want for the checkbox associated with that installer, any alternate path if it is a two-part installer, and command line switches that you would like. ( /norestart, /q, /ra, etc.) 

Since the script is running within a single thread the GUI will freeze once you hit "Install". Once it is done running the selected installers, the GUI will update. In the meantime, there is a CMD window that will be open in the background writing to the host as it installs software and completes.

## Code Example
CD to the directory and execute the script.
```powershell
# Change to script directory
cd \\ScriptServer\SoftwareInstaller\
# Execute Script
. .\Run-CustomInstallers
```
It will then display the GUI

![alt text](https://i.imgur.com/tt2sfYp.png "Run-CustomInstaller GUI")

## Motivation

When I was previously working as a PC technician, I would have to install different pieces of software for different departments. I could never have the software preinstalled in the image since the image was used for multiple departments. There just too many one-offs at the time. I wrote this to help cut down on time spent crawling directories to run EXE and BAT installers.

## Installation

Simply drop the Run-CustomInstaller.ps1 script and the Filepaths.csv files into the same directory. Change the filepaths.csv to point to the software in your environment. Once the filepaths is set up, execute the script and then you should be good to go.

## Contributors

Feel free to contact me on twitter or on here if you have any questions. I'd be glad to help.
