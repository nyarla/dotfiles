$rootDir = 'C:\Users\nyarla\Documents\Image-Line\FL Studio\Presets\Plugin database\Installed'
$vendorDir = 'C:\Users\nyarla\Documents\Image-Line\FL Studio\Presets\Plugin database\ByVendor'

function Get-VSTVendor() {
  param (
    $VSTPath
  )

  ((Select-String -Path $VSTPath -Pattern '_vendorname_' | Select-Object -First 1 ) -split "=" )[1]
}

function Get-VSTVendorPath() {
  param (
    $VSTPath
  )

  (Get-VSTVendor -VSTPath $VSTPath) -replace '[^a-zA-Z0-9\._ ]','_'
}

function main() {
  foreach ($prefix in @("Generators", "Effects")) {
    foreach ($type in @("VST", "VST3")) {
      $plugins = Get-ChildItem "$rootDir\$prefix\$type" -Recurse -File -Name -include *.fst
     
      foreach ($plugin in $plugins) {
        Write-Output $plugin

        $basedir = "$rootDir\$prefix\$type"

        $nfo = $plugin.replace('.fst', '.nfo')
        $fst = $plugin

        $vendor = Get-VSTVendor -VSTPath "$basedir\$nfo"
        $dirname = Get-VSTVendorPath -VSTPath "$basedir\$nfo"

        $nfoFile = "$basedir\$nfo"
        $fstFile = "$basedir\$fst"

        $destdir = "$vendorDir\$dirname\$prefix"

        if (! (Test-Path -Path $destdir)) {
          New-Item -Path $destdir -ItemType "directory"
        }

        if (! (Test-Path -Path "$destdir\$fst")) {
          Copy-Item -Path $fstFile -Destination "$destdir\$fst" -Force
        }

        if (! (Test-Path -Path "$destdir\$nfo")) {
          Copy-Item -Path $nfoFile -Destination "$destdir\$nfo" -Force
          (Get-Content "$destdir\$nfo").Replace("%FLPluginDBPath%\Installed\$prefix\$type","%FLPluginDBPath%\ByVendor\$dirname\$prefix") | Set-Content "$destdir\$nfo"
        }
      }
    }
  }
}

main
