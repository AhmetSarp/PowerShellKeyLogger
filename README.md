# PowerShellKeyLogger
*It is a PowerShell code that records keystrokes both in xml and txt files. To prevent loss of file when it executed more than once, it<br /> <br />saves the file names as "keylogger date". Xml file holds three attributes per keystroke which are "Number", "Button"(Name) and <br /> <br />"Time" attributes.*

## How it works?
*When it starts it scans ascii codes between 8 and 129. Foreach ascii code, it gets key state from system. If something pressed, it <br /> <br /> translates scan to to real code. After that it translates virtual key to StringBuilder. When it successes, it adds the record to <br /> <br />both xml  and txt files.*

## Execution-Policy Problem
*In case of "this file is not digitally signed" exception.*

*Execute PowerShell command "Set-ExecutionPolicy remoteSigned"*

## Usage
*Execute PowerShell command ".\keylogger.ps1" to start KeyLogger <br /> <br />*
*Press "CTRL + C" to stop*
