# PowerShellKeyLogger
*It is a PowerShell code that records keystrokes both in xml and txt files. To prevent loss of file when it executed more than once, it<br /> <br />saves the file names as "keylogger date". Xml file holds three attributes per keystroke which are "Number", "Button"(Name) and <br /> <br />"Time" attributes.*

## How it works?
*When it starts, every 20 miliseconds it scans ascii codes between 8 and 129 . Foreach ascii code, it gets key state from system. If <br /> <br />something  pressed, it  translates scan to real code. After that it translates virtual key to StringBuilder. When it successes, it adds <br /> <br /> the record to both xml  and txt files. In the end, It prints the total number of keystrokes to powershell console.*

## Execution-Policy Problem
*In case of "this file is not digitally signed" exception.*

*Execute PowerShell command "Set-ExecutionPolicy remoteSigned"* <br /> <br />
![1](https://user-images.githubusercontent.com/25460311/38175431-0ff010b8-35e5-11e8-943c-33a355181353.PNG)

## Usage
*Execute PowerShell command ".\keylogger.ps1" to start KeyLogger <br /> <br />*
*Press "CTRL + C" to stop*  <br /> <br />
##### Example Usage
*There are screenshots for demo.* <br /> <br />
*This image shows that hot it works and how it outputs in the end.* <br /> <br />
![2](https://user-images.githubusercontent.com/25460311/38175424-fbb43e76-35e4-11e8-898e-10050b2274fb.PNG)<br /> <br />
*This image shows an example of xml file that records attributes.* <br /> <br />
![3](https://user-images.githubusercontent.com/25460311/38175427-feb5f3ee-35e4-11e8-996a-628714a3edba.PNG)<br /> <br />
*Final image shows us the txt file output.* <br /> <br />
![4](https://user-images.githubusercontent.com/25460311/38175428-042fe6f4-35e5-11e8-8575-9f7461fcd644.PNG)<br /> <br />

