$age_public_key = ""
Get-ChildItem -Filter *.7z | ForEach-Object {
  age -r $age_public_key -o "$_.age" "$_"
  }