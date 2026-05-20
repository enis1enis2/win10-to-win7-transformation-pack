HomeGroup, removed since Windows 10 Version 1803 is now back:
1. Replace the C:\Windows\System32\stobject.dll.
2. Import the regkeys in TI and Normal.
3. Add the value "HomeGroupListener" to the value named "LocalSystemNetworkRestricted" and the value "HomeGroupProvider" to the value named "LocalServiceNetworkRestricted" all at location
"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost", then restart your PC and start the services.

How to use?
Ensure that the HomeGroup services are running and other PCs are on the same LAN as yours. 
Also ensure that Network discovery is opened and your network location is set to Private.
Note that some antivirus softwares may block HomeGroup communication activities.

Edit:
1. File version: stobject.dll 10.0.14393.7426.
2. It doesn't work on Windows 11 because from Windows 11 Build 20231 Microsoft had completely removed the HomeGroup components.
3. You no longer need to use Winaero Tweaker to add HomeGroup to the Windows Explorer navpane. If you want the original homegroup navpane item to be like how it was on Windows 7, just go to "HKEY_CLASSES_ROOT\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}" and "HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}", then change the sortorderindex to 46. Thanks to Nex!

Special thanks to Windows 10 Anniversary Update !

Credit: Brawllux  Petya 

Source: https://winclassic.net/thread/3278/windows-homegroup-version-1803-22h2