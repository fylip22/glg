Function ResizeImage() {
    param(
        [String]$ImagePath, 
        [Int]$Quality = 90, 
        [Int]$targetSize,
        [String]$OutputLocation)
 
    Add-Type -AssemblyName "System.Drawing"
 
    $img = [System.Drawing.Image]::FromFile($ImagePath)
 
    $CanvasWidth = $targetSize
    $CanvasHeight = $targetSize
 
    #Encoder parameter for image quality
    $ImageEncoder = [System.Drawing.Imaging.Encoder]::Quality
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($ImageEncoder, $Quality)
 
    # get codec
    $Codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where {$_.MimeType -eq 'image/jpeg'}
 
    #compute the final ratio to use
    $ratioX = $CanvasWidth / $img.Width;
    $ratioY = $CanvasHeight / $img.Height;
 
    $ratio = $ratioY
    if ($ratioX -le $ratioY) {
        $ratio = $ratioX
    }
 
    $newWidth = [int] ($img.Width * $ratio)
    $newHeight = [int] ($img.Height * $ratio)
 
    $bmpResized = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
    $bmpResized.SetResolution(300,300)
    $graph = [System.Drawing.Graphics]::FromImage($bmpResized)
    $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
 
    $graph.Clear([System.Drawing.Color]::White)
    $graph.DrawImage($img, 0, 0, $newWidth, $newHeight)
 
    #save to file
    $bmpResized.Save($OutputLocation, $Codec, $($encoderParams))
    $bmpResized.Dispose()
    $img.Dispose()
}

Clear-Host

$MonFichier = ""
$FichiersListe = ""
$Chemin = "C:\tmp\"

Set-Location $Chemin

$FichiersListe = Get-ChildItem -path $chemin -file *.jpg -recurse
#$Date = Get-Date -Format "-mieux"

ForEach($MonFichier in $FichiersListe) {
    #$FichierDateCreation = $MonFichier.CreationTime
    $FichierDateModif = $MonFichier.LastWriteTime
    #$FichierDateAcces = $MonFichier.LastAccessTime

    $NouveauNom = $MonFichier.basename+"-mieux-1024"+".jpg"
    $NouveauFichier = New-Item -Name $NouveauNom -ItemType "file"
   
    ResizeImage $MonFichier.FullName 85 1024 ($Chemin+"\"+$NouveauFichier.name)
    Set-Location $Chemin
    $NouveauFichier.CreationTime = $FichierDateModif
    $NouveauFichier.LastWriteTime = $FichierDateModif
    $NouveauFichier.LastAccessTime = $FichierDateModif
    remove-item $Monfichier
    rename-item $NouveauFichier $MonFichier
    write-host "Fichier traité :" $NouveauFichier
}
Write-Host "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * "
Write-Host "Traitement terminé"

#fonctionne
