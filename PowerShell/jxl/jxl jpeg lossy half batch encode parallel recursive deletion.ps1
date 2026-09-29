Get-ChildItem -Filter *.jpg -Recurse | ForEach-Object -Parallel {
  $outputFile = Join-Path $_.DirectoryName "$($_.BaseName).jxl"
  magick $_.FullName -resize 50% pam:- | cjxl - $outputFile -d 2 -e 7 --brotli_effort=9 -j 0 -x strip=exif
  if ($LASTEXITCODE -eq 0) {
    (Get-Item $outputFile).LastWriteTime = $_.LastWriteTime
    Remove-Item $_.FullName
  } else {
    Write-Warning "Failed to convert: $($_.FullName). Original file preserved."
  }
} -ThrottleLimit 2