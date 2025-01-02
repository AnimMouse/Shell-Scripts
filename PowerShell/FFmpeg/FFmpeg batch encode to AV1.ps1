Get-ChildItem -Filter *.mp4 | ForEach-Object {
  $output = $_.Basename
  ffmpeg -hide_banner -i "$_" -c:v libsvtav1 `
  -preset 6 -crf 34 -pix_fmt yuv420p10le `
  -svtav1-params "tune=0:keyint=10s:enable-overlays=1" `
  -c:a libopus -b:a 64k "$output.mkv"
  }