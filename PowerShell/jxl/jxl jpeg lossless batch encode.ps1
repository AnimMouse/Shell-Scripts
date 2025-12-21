Get-ChildItem -Filter *.jpg | ForEach-Object {
  $output = $_.Basename
  cjxl -e 8 --brotli_effort=9 -j 1 "$_" "$output.jxl"
  (Get-Item "$output.jxl").LastWriteTime = (Get-Item "$_").LastWriteTime
}