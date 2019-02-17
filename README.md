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

### Convert a Disqus export to a PowerShell Object

```powershell
.\PSDisqusImport.ps1 -Path MyDisqusExport.xml
```

Example of output

```
AuthorName        : Xavier
ThreadPostLink    : http://www.lazywinadmin.com/2011/06/powershell-and-windows-updates.html
Message           : <p>see also:<br><br><a href="http://blogs.technet.com/b/jamesone/archive/2009/01/27/managing-window
                    s-update-with-powershell.aspx" rel="nofollow noopener" title="http://blogs.technet.com/b/jamesone/a
                    rchive/2009/01/27/managing-windows-update-with-powershell.aspx">http://blogs.technet.com/b/...</a><
                    br><br><a href="http://poshcode.org/1932" rel="nofollow noopener"
                    title="http://poshcode.org/1932">http://poshcode.org/1932</a><br><br><a href="http://blog.powershel
                    l.no/2010/06/25/manage-windows-update-installations-using-windows-powershell/" rel="nofollow
                    noopener" title="http://blog.powershell.no/2010/06/25/manage-windows-update-installations-using-win
                    dows-powershell/">http://blog.powershell.no/2...</a></p>
ThreadCreatedAt   : 2014-02-21T01:47:54Z
ThreadForum       : lazywinadmin
AuthorIsAnonymous : true
isDeleted         : false
ThreadId          : 2296517329
DsqID             : 1254333011
ID                : 6976527284789885127
createdAt         : 2012-04-18T19:26:20Z
ThreadPostTitle   : http://www.lazywinadmin.com/2010/09/active-directory-saved-queries-aduc-mmc.html
isSpam            : false

AuthorName        : Anonymous
ThreadPostLink    : http://www.lazywinadmin.com/2010/09/active-directory-saved-queries-aduc-mmc.html
Message           : <p>You need to remove the Not operator (Exclamation mark) from "Finds all disabled accounts in
                    active directory".  It should be :-<br><br>(objectCategory=person)(objectClass=user)(useraccountcon
                    trol:1.2.840.113556.1.4.803:=2)</p>
ThreadCreatedAt   : 2014-02-21T01:47:54Z
ThreadForum       : lazywinadmin
AuthorIsAnonymous : true
isDeleted         : false
ThreadId          : 2296517344
DsqID             : 1254333010
ID                : 428262410100970062
createdAt         : 2012-04-18T19:57:18Z
ThreadPostTitle   : http://www.lazywinadmin.com/2010/09/active-directory-saved-queries-aduc-mmc.html
isSpam            : false
```



### Convert a Disqus export to a Json Object

```powershell
.\PSDisqusImport.ps1 -Path MyDisqusExport.xml | ConvertTo-Json
```

