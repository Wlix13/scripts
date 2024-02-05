# Auto-completion modules
Install-Module -Name Microsoft.PowerShell.UnixTabCompletion -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber
Install-Module -Name posh-cli -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber
Install-TabCompletion

# Quality of life modules
Install-Module -Name PSReadLine -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber
Install-Module -Name Terminal-Icons -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber
Install-Module -Name Pansies -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber
Install-Module -Name z -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber

# Misc modules
Install-Module -Name Pode -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber
Install-Module -Name PS-Menu -Repository PSGallery -AllowPrerelease -AcceptLicense -Confirm:$false -Force -AllowClobber