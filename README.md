# PSDisqusImport

Script to convert a Disqus comments present in the Export generated on the Disqus website to a PowerShell Object.

## Description

Note that the original format of the XML is not kept.
The script will combine the threads and comments (called post in the Export) into one object.

I moved my website to static pages hosted on GitHub Pages.
The current Comment System used is hosted externally in Disqus.

I want to move that piece to files and use something like StaticMan
This module will help me with that :-)

Disqus Export can be found on the Disqus website under the admin portal: select "Community" and then "Export"
A download link to a compressed GZ file will be send to your email.

See: https://help.disqus.com/developer/comments-export

## Installation

Install the script from the PowerShell Gallery

```powershell
Install-Script -Name PSDisqusImport -Scope CurrentUser
```

## Usage

Convert a Disqus export to a PowerShell Object

```powershell
.\PSDisqusImport.ps1 -Path MyDisqusExport.xml
```

Convert a Disqus export to a Json Object

```powershell
.\PSDisqusImport.ps1 -Path MyDisqusExport.xml | ConvertTo-Json
```