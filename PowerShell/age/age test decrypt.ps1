$age_private_key = Read-Host -Prompt "Input the private key that will be used to decrypt"
$filename = Read-Host -Prompt "Input the filename to decrypt"
$output = "Test $([System.IO.Path]::GetFileNameWithoutExtension($filename))"
$age_private_key | age -d -i - -o "$output" "$filename"