# Define paths
$originalDir = ".\Original"
$compressedDir = ".\Compressed"
$destDir = ".\Destination"

# Create destination folder if it doesn't exist
if (-not (Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
}

# Get all .jpg files from the Compressed directory
$compressedFiles = Get-ChildItem -Path $compressedDir -Filter "*.jxl"

foreach ($file in $compressedFiles) {
    # Construct target path in Original folder
    $originalFile = Join-Path -Path $originalDir -ChildPath $file.Name

    # Check if the file exists in Original before copying
    if (Test-Path -Path $originalFile) {
        Copy-Item -Path $originalFile -Destination $destDir
        Write-Host "Copied: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Warning "$($file.Name) not found in Original folder."
    }
}

Write-Host "Done! Check '$destDir'." -ForegroundColor Cyan