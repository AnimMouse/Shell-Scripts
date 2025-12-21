$age_public_key = Read-Host -Prompt "Input the public key that will be used to encrypt"
$filename = Read-Host -Prompt "Input the filename to encrypt"
age -r $age_public_key -o "$filename.age" "$filename"