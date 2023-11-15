# ---
# Overwrite default functions
# ---
function New-Alias {
    $argsPassed = $args
    $AliasName = $args[0]
    
    if (-not (Get-Alias $AliasName -ErrorAction SilentlyContinue)) {
        Microsoft.PowerShell.Utility\New-Alias @argsPassed -Scope Global
    }
}


function Set-Location {
    $argsPassed = $args

    Microsoft.PowerShell.Management\Set-Location @argsPassed

    if (Test-Path .\.env) {
        Add-Env
    }
}

# ---
# Custom functions
# ---
function Get-TimePythonScript {
    param([string]$scriptName)
    Measure-Command { start-process python -ArgumentList $scriptName -Wait }
}

function ConvertTo-PDF {
    param (
        [Parameter(Mandatory = $true)]
        [string]$InputFile,

        [string]$Font = "Arial",

        [bool]$CoverImage = $false,

        [string]$OutputFile = "",

        [string]$OtherParameters = ""
    )
    if ($InputFile -notlike "*.md") {
        Write-Error "Input file must be a markdown file!"
        return
    }
    if ($OutputFile -and $OutputFile -notlike "*.pdf") {
        Write-Error "Output file must be a pdf file!"
        return
    }

    $InputFile = (Get-Item $InputFile).Name
    $baseCommand = "pandoc --pdf-engine=xelatex -V geometry:a4paper -V geometry:margin=2cm"

    switch ($PSVersionTable.OS) {
        { $_ -like "Microsoft Windows*" } {
            $workingDir = (Get-Item $InputFile).Directory.FullName
            $baseCommand = "wsl --cd `'$workingDir`' -e $baseCommand"
            $stylePath = "/mnt/d/OneDrive/Documents/TexStyle"
        }
        { $_ -like "Darwin*" } {
            $stylePath = "/Users/wlix/Library/CloudStorage/OneDrive-Personal/Documents/TexStyle"
        }
        { $_ -like "Linux*" } {
            $stylePath = "/mnt/d/OneDrive/Documents/TexStyle"
        }
        default {
            Write-Error "Unknown OS!"
            return
        }
    }
    $baseCommand += " -H `'$stylePath/style.tex`'"

    switch ($Font) {
        "Fira" {
            $font = "Fira Code Regular Nerd Font Complete"
        }
        "Arial" {
            $font = "Arial"
        }
        default {
            Write-Error "Unsupported font: $Font"
            return
        }
    }
    $baseCommand += " -V mainfont=$font -V sansfont=$font"
    $baseCommand += " -V monofont=`'Fira Code Regular Nerd Font Complete`'"

    if ($CoverImage) {
        $baseCommand += " --include-before-body `'$stylePath/cover.tex`'"
    }

    if ($OtherParameters) {
        $baseCommand += " $OtherParameters"
    }

    
    if (-not $OutputFile) {
        $OutputFile = "$(Get-Item $InputFile).BaseName + .pdf"
    }

    $baseCommand += " -s `'$InputFile`'"
    $baseCommand += " -o `'$OutputFile`'"

    Invoke-Expression $baseCommand
}


function Convert-ToJpeg {
    param(
        [string]$Path = ".",
        [int]$JpegQuality = 100,
        [System.Drawing.Color]$PaddingColor = [System.Drawing.Color]::White
    )

    Add-Type -AssemblyName System.Drawing

    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $JpegQuality)

    $jpegCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }

    $imageFiles = Get-ChildItem -Path $Path -Recurse | Where-Object { $_.Extension -notin @('.jpeg', '.jpg') -and $_.Attributes -ne 'Directory' }

    foreach ($file in $imageFiles) {
        try {
            $image = [System.Drawing.Image]::FromFile($file.FullName)

            # Determine dimensions for padding if needed
            $targetWidth = $image.Width
            $targetHeight = $image.Height

            # Create a new bitmap with target size which will be final image
            $bitmap = New-Object System.Drawing.Bitmap $targetWidth, $targetHeight

            # Create graphics object for alteration
            $graphics = [System.Drawing.Graphics]::FromImage($bitmap)

            # Set background color
            $graphics.Clear($PaddingColor)

            # Draw original image on top of new canvas
            $graphics.DrawImage($image, 0, 0, $image.Width, $image.Height)

            $jpegFileName = [IO.Path]::Combine($file.DirectoryName, [IO.Path]::GetFileNameWithoutExtension($file.Name) + '.jpeg')

            # Save bitmap (with original image and padding) as a JPEG
            $bitmap.Save($jpegFileName, $jpegCodecInfo, $encoderParams)

            Write-Host "Converted file saved as: $jpegFileName"
        }
        catch {
            Write-Error "Error processing file '$($file.Name)': $_"
        }
        finally {
            if ($null -ne $image) {
                $image.Dispose()
            }
            if ($null -ne $bitmap) {
                $bitmap.Dispose()
            }
            if ($null -ne $graphics) {
                $graphics.Dispose()
            }
        }
    }

    $encoderParams.Dispose()
}