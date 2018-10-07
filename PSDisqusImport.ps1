
<#PSScriptInfo

.VERSION 1.0.0

.GUID ec461ea9-55b9-468a-8a71-a7545a65dec2

.AUTHOR Francois-Xavier Cat

.COMPANYNAME LazyWinAdmin.com

.COPYRIGHT Copyright (c) 2018 François-Xavier Cat

.TAGS Disqus Comment XML

.LICENSEURI https://github.com/lazywinadmin/PSDisqusImport/blob/master/LICENSE

.PROJECTURI https://github.com/lazywinadmin/PSDisqusImport

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES
Initial Version

#>

<#
.SYNOPSIS
    Script to convert a Disqus export to a PowerShell Object

.DESCRIPTION
    Note that the original format of the XML is not kept.
    The script will combine the threads and comments (called post in the Export) into one object.

    I moved my website to static pages hosted on GitHub Pages.
    The current Comment System used is hosted externally in Disqus.

    I want to move that piece to files and use something like StaticMan
    This module will help me with that :-)

    Disqus Export can be found on the Disqus website under the admin portal: select "Community" and then "Export"
    A download link to a compressed GZ file will be send to your email.

.PARAMETER Path
    Specify the path to the Disqus Export

.EXAMPLE
    .\PSDisqusImport.ps1 -Path MyDisqusExport.xml

    Convert a Disqus export to a PowerShell Object
.EXAMPLE
    .\PSDisqusImport.ps1 -Path MyDisqusExport.xml | ConvertTo-Json

    Convert a Disqus export to a Json Object
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [System.String]$Path)
Try
{
    $ScriptName = $MyInvocation.MyCommand.Name
    $ScriptCommand =$MyInvocation.Line
    Write-Verbose -Message "[$ScriptName] Command '$ScriptCommand'"
    
    Write-Verbose -Message "[$ScriptName] Load the file '$(Resolve-Path -Path $Path)' and interprete the XML"
    $Disqus = Get-Content -Path $Path
    $DisqusXML = ([xml]$Disqus).disqus

    Write-Verbose -Message "[$ScriptName] Retrieve threads"
    $AllThreads = $DisqusXML.thread

    Write-Verbose -Message "[$ScriptName] Retrieve Comments"
    $AllComments = $DisqusXML.post
    $Properties = $AllComments | Get-Member -MemberType Property
    $AllComments | Foreach-Object -process {
        # Current Comment
        $Comment = $_
        # Create Hashtable
        $Post = @{}
        foreach ($prop in $Properties.name)
        {
            if($prop -eq 'id')
            {
                $Post.DsqID = $Comment.id[0]
                $Post.ID = $Comment.id[1]
            }
            elseif($prop -eq 'author')
            {
                $Post.AuthorName = $Comment.author.name
                $Post.AuthorIsAnonymous = $Comment.author.isanonymous
            }
            elseif($prop -eq 'thread')
            {
                $Post.ThreadId = $Comment.thread.id
                $ThreadInfo = $AllThreads | where-object -FilterScript {$_.id[0] -eq $($Post.ThreadId)}
                if($ThreadInfo)
                {
                    #$Post.ThreadPostPath = ''#if(($ThreadInfo.id|Measure-Object).count -gt 1){$ThreadInfo.id[1]}
                    $Post.ThreadPostLink = $ThreadInfo.Link
                    $Post.ThreadPostTitle = $ThreadInfo.title
                    $Post.ThreadCreatedAt = $ThreadInfo.CreatedAt
                    $Post.ThreadForum = $ThreadInfo.Forum
                }
            }
            elseif($prop -eq 'message')
            {
                $Post.Message = $Comment.message.'#cdata-section'
            }
            else{
            
                $Post.$prop = $Comment | Select-Object -ExpandProperty $prop |out-string
            }
        }
        # Return a PowerShell object for the current comment
        New-Object -TypeName PSObject -Property $Post
    }
}
Catch
{
    throw $_
}