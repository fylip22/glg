#
#
#

$Chemin = "C:\tmp\"

Set-Location $Chemin

$FichierListe = Get-ChildItem -file -path $chemin -Filter *.jpg
Clear-Host
$FichierListe

foreach ($Fichier in $FichierListe) {
    #Start-Process -Wait -FilePath "C:\tmp\nconvert.exe $Fichier" -ArgumentList "-npcd 2 -size 256x256+0 -ctype rgb -corder inter -out jpeg -D -dpi 300 -ratio -rtype lanczos -rflag decr -rflag orient -resize 1024 1024" -PassThru
    #Start-Process "C:\tmp\\nconvert\nconvert.exe" -ArgumentList "$Fichier", "-npcd 2", "-size 256x256+0", "-ctype rgb", "-corder inter", "-out jpeg", "-D", "-dpi 300", "-ratio", "-rtype lanczos", "-rflag decr", "-rflag orient", "-resize 1024 1024"
    #C:\tmp\nconvert -npcd 2 -size 256x256+0 -ctype rgb -corder inter -out jpeg -D -dpi 300 -ratio -rtype lanczos -rflag decr -rflag orient -resize 1024 1024 -overwrite $Fichier
    #nconvert.exe -resize 50% 50% -o jpeg -q 80 -overwrite $Fichier 
    #Start-Process "C:\tmp\nconvert\nconvert.exe" -ArgumentList $Fichier, "-npcd 2", "-size", "256x256+0", "-ctype", "rgb", "-corder", "inter", "-out", "jpeg", "-D", "-dpi", "300", "-ratio", "-rtype", "lanczos", "-rflag", "decr", "-rflag", "orient", "-resize", "1024", "1024"
    $Fichier = '"' + $Fichier.name + '"'
    $fichier
    #$arguments = "-resize","1024","1024"
    #$arguments = "convert", "-resize", "1024", "1024", "-npcd 2", "-size", "256x256+0", "-ctype", "rgb", "-corder", "inter", "-out", "jpeg", "-D", "-dpi", "300", "-ratio", "-rtype", "lanczos", "-rflag", "decr", "-rflag", "orient"
    $arguments1 = "-resize", "1024", "1024"
    $arguments2 = "-rtype", "lanczos"
    $arguments = "-resize", "1024", "1024","-rtype", "lanczos"

    #$arguments = "-resize","1024","1024"
    C:\tmp\nconvert\nconvert.exe $arguments2 $fichier
    }
