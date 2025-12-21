$coreCount = [System.Environment]::ProcessorCount
Get-ChildItem -Filter *.jpg -Recurse | ForEach-Object -Parallel {
  $outputFile = Join-Path $_.DirectoryName "$($_.BaseName).jxl"
  cjxl -e 8 --brotli_effort=9 -j 1 $_.FullName $outputFile
  (Get-Item $outputFile).LastWriteTime = $_.LastWriteTime
} -ThrottleLimit $coreCount