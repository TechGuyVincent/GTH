##############################################
# Webpage -> AZcopy script version 0.1 
#
# Install instructions - Use the script as you want :) / Created by Vincent J (ATT)
#---------------------------------------------------------------------------------------------
#
# What it does
# --------------------- 
# This script creates an HTML file and uploads it to an Azure storage account. You can add a message/link and linktext.
# This is great to get a message out to people, by accessing a specific URL in the case that something happens. 
#
# PREREQ: 
#
# - Create a Storage Account in Azure. Create a container and upload an html file with the same name as what you create with this script.  
# - Create a SAS link (on a blob level) and give it read/write permissions and set the date ahead of time (1-2 years). 
# - Download the azcopy.exe
# - (Register an aka.ms URL and point it to the file in the storageaccount). 
# - Set the paramaters in the script below (look at the parmeters part at the bottom of the script). 
# - Run the script - done :) 
###############################################

$message = Read-Host "What message do you want to include" 
$link = Read-Host "Paste a link here - leave blank for none"
$linktext = Read-Host "Add link text - leave blank for none"
$date = Get-Date -Format "dddd dd/MM/yyyy HH:mm"


$htmlexport = @"
<!DOCTYPE html>
<html lang="en">
<style>
body {
  background-color:#fff!important;
  background-image:url("bg.jpg")!important;
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: 50% 50%;
  color:#000!important;
}
</style>
<head>
  <meta name="robots" content="noindex">
  <title>Delivery info</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
  <h2>Last message date/time: $date</h2>
 <! Change the alert colors by changing alert alert-success (green) / alert-info (Blue) / alert-warning (yellow) / alert-danger (red) ->
 <div class="alert alert-danger">
    <h3>$message <a href="$link">$linktext</a></h3>
  </div>
</div>

</body>
</html>

"@

###############
# Parameters
# ------------  
#
# Set the out file to the same directory as the azcopy.exe if you want. You can also add a bg image and change it if you want and just add it in the storage accunt in the same container as the html file. 
# When running azcopy.exe - copy, make sure you run the path where the file is located and followed by the storage SAS URL (The whole filename + the SAS string). 
# 
# Example - C:\path\azcopy.exe copy "C:\pathtofile\file.html" "https://storageaccountname.blob.core.windows.net/container/file.html?sp=rcwd&st=2020-05-12T21:09:02Z&se=2022-0....."
#
# Start-Process "https://aka.ms/yourURLhere" (it will open up the webpage after the sync
################

$htmlexport | Out-File C:\pathtofile\file.html

C:\path\azcopy.exe copy "C:\pathtofile\file.html" "https://storageaccountname.blob.core.windows.net/container/file.html?sp=rcwd&st=2020-05-12T21:09:02Z&se=2022-0....."

Start-Process "https://aka.ms/yoururl"