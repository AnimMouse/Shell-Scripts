Get-ChildItem -Filter *.jxl -Recurse | ForEach-Object -Parallel {
    $originalPath = $_.FullName
    $tempFile = Join-Path $_.DirectoryName "$($_.BaseName).tmp.jxl"
    magick $originalPath -resize 50% pam:- | cjxl - $tempFile -d 2 -e 7 --brotli_effort=9 -j 0 -x strip=exif
    if ($LASTEXITCODE -eq 0 -and (Test-Path $tempFile)) {
        (Get-Item $tempFile).LastWriteTime = $_.LastWriteTime
        Move-Item -Path $tempFile -Destination $originalPath -Force
    } else {
        if (Test-Path $tempFile) { Remove-Item $tempFile -Force }
        Write-Warning "Failed to convert: $originalPath. Original file preserved."
    }
} -ThrottleLimit 2