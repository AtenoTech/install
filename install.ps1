# For your Windows users
echo "Downloading Ateno for Windows..."
$url = "https://github.com/AtenoTech/ateno-js/releases/latest/download/ateno-win-x64.zip"
$dest = "$env:TEMP\ateno.zip"
Invoke-WebRequest -Uri $url -OutFile $dest
Expand-Archive -Path $dest -DestinationPath "$env:USERPROFILE\ateno"
# Add to User PATH
$path = [Environment]::GetEnvironmentVariable("Path", "User")
[Environment]::SetEnvironmentVariable("Path", "$path;$env:USERPROFILE\ateno", "User")
echo "Done! Restart your terminal."