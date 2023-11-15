[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Alias("SAN")]
    [string]
    $SubjectAltName
)

$cn = $SubjectAltName.Split(",")[0];

Invoke-Expression "openssl genrsa -out intermediate/private/$cn.key.pem 2048";
Invoke-Expression "openssl req -config intermediate/openssl.cnf -key intermediate/private/$cn.key.pem -new -sha256 -out intermediate/csr/$cn.csr.pem -addext `"subjectAltName = $($SubjectAltName.Split(",") | Join-String -OutputPrefix "DNS:" -Separator ",DNS:")`"";
Invoke-Expression "openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 1100 -notext -md sha256 -in intermediate/csr/$cn.csr.pem -out intermediate/certs/$cn.cert.pem";
Invoke-Expression "openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/$cn.cert.pem";

New-Item -Path "../Complete" -ItemType "directory" -Force | Out-Null;
New-Item -Path "../Complete/$cn" -ItemType "directory" -Force | Out-Null;

Copy-Item -Path "intermediate/private/$cn.key.pem" -Destination "../Complete/$cn" -Force | Out-Null;
Copy-Item -Path "intermediate/csr/$cn.csr.pem" -Destination "../Complete/$cn" -Force | Out-Null;
Copy-Item -Path "intermediate/certs/$cn.cert.pem" -Destination "../Complete/$cn" -Force | Out-Null;