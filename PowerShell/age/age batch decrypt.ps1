$age_private_key = ""
Get-ChildItem -Filter *.age | ForEach-Object {
  $output = $_.BaseName
  $age_private_key | age -d -i - -o "$output" "$_"
  }