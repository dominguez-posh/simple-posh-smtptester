
function Send-Mail($SMTPServer, $Port, $From, $To, $Subject, $Body){


$Error[0] = $Null


$mailParams = @{
    SmtpServer = $SMTPServer
    Port = $Port
    From = $From
    To = $To
    Subject = $Subject
    Body = $Body
}

if($objCheckBoxAuth.checked -eq $true){

if($objCheckBoxSSL.checked -eq $true){
   
    $Result = Send-MailMessage @mailParams -UseSsl -Credential Get-Credential

}
else
{
 
    $Result = Send-MailMessage @mailParams -Credential Get-Credential
}
}
else{

if($objCheckBoxSSL.checked -eq $true){
   
    $Result = Send-MailMessage @mailParams -UseSsl 

}
else
{
 
    $Result = Send-MailMessage @mailParams
}

}



if($Error[0] -eq $null){

$objTextBoxResult.Text = "Mail Erfolgreich versandt!"


}
else{

$objTextBoxResult.Text = $Error[0]

}

$objForm.Update()

}





[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")




$objForm = New-Object System.Windows.Forms.Form

$objForm.Size = New-Object System.Drawing.Size(400,500)

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(100,60)
$objLabel.Size = New-Object System.Drawing.Size(1000,20)
$objLabel.Text = "Einfacher SMTP-Relay-Tester"
$objForm.Controls.Add($objLabel)





$objTextBoxSmtpServer = New-Object System.Windows.Forms.TextBox
$objTextBoxSmtpServer.Location = New-Object System.Drawing.Size(100,100)
$objTextBoxSmtpServer.Size = New-Object System.Drawing.Size(200,20)
$objForm.Controls.Add($objTextBoxSmtpServer)
$objTextBoxSmtpServer.Text = "<SMTP-Server>"

$objCheckBoxSSL = New-Object System.Windows.Forms.checkbox
$objCheckBoxSSL.Location = New-Object System.Drawing.Size(160,130)
$objCheckBoxSSL.Size = New-Object System.Drawing.Size(100,20)
$objCheckBoxSSL.Checked = $false
$objCheckBoxSSL.Text = "SSL"
$objForm.Controls.Add($objCheckBoxSSL)


$objTextBoxPort = New-Object System.Windows.Forms.TextBox
$objTextBoxPort.Location = New-Object System.Drawing.Size(100,130)
$objTextBoxPort.Size = New-Object System.Drawing.Size(50,20)
$objForm.Controls.Add($objTextBoxPort)
$objTextBoxPort.Text = "<Port>"

$objTextBoxFrom = New-Object System.Windows.Forms.TextBox
$objTextBoxFrom.Location = New-Object System.Drawing.Size(100,160)
$objTextBoxFrom.Size = New-Object System.Drawing.Size(200,20)
$objForm.Controls.Add($objTextBoxFrom)
$objTextBoxFrom.Text = "<From>"

$objTextBoxTo = New-Object System.Windows.Forms.TextBox
$objTextBoxTo.Location = New-Object System.Drawing.Size(100,180)
$objTextBoxTo.Size = New-Object System.Drawing.Size(200,20)
$objForm.Controls.Add($objTextBoxTo)
$objTextBoxTo.Text = "<To>"

$objTextBoxSubject = New-Object System.Windows.Forms.TextBox
$objTextBoxSubject.Location = New-Object System.Drawing.Size(100,220)
$objTextBoxSubject.Size = New-Object System.Drawing.Size(200,20)
$objForm.Controls.Add($objTextBoxSubject)
$objTextBoxSubject.Text = ('SMTP Relay - ' + (Get-Date -Format g))

$objTextBoxBody = New-Object System.Windows.Forms.TextBox
$objTextBoxBody.Location = New-Object System.Drawing.Size(100,250)
$objTextBoxBody.Size = New-Object System.Drawing.Size(200,20)
$objForm.Controls.Add($objTextBoxBody)
$objTextBoxBody.Text = 'This is a test email using SMTP Relay'

$objCheckBoxAuth = New-Object System.Windows.Forms.checkbox
$objCheckBoxAuth.Location = New-Object System.Drawing.Size(100,270)
$objCheckBoxAuth.Size = New-Object System.Drawing.Size(100,20)
$objCheckBoxAuth.Checked = $false
$objCheckBoxAuth.Text = "Auth"
$objForm.Controls.Add($objCheckBoxAuth)


$SendButton = New-Object System.Windows.Forms.Button
$SendButton.Location = New-Object System.Drawing.Size(100,340)
$SendButton.Size = New-Object System.Drawing.Size(75,23)
$SendButton.Text = "Send"
$SendButton.Name = "Send"
$SendButton.Add_Click({Send-Mail $objTextBoxSmtpServer.Text $objTextBoxPort.Text $objTextBoxFrom.Text $objTextBoxTo.Text $objTextBoxSubject.Text $objTextBoxBody.Text})
$objForm.Controls.Add($SendButton)



$objTextBoxResult = New-Object System.Windows.Forms.RichTextBox 
$objTextBoxResult.Location = New-Object System.Drawing.Size(100,370)
$objTextBoxResult.Size = New-Object System.Drawing.Size(200,90)
$objTextBoxResult.MultiLine = $True 
$objForm.Controls.Add($objTextBoxResult)
$objTextBoxResult.Text = 'Result'





[void] $objForm.ShowDialog()