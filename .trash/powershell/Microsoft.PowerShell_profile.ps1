# prompt
Invoke-Expression (&starship init powershell)

# cmdlet
Import-Module ZLocation
Import-Module PSFzf

# unix-like command
@"
  arch, base32, base64, basename, cat, cksum, comm, cp, cut, date, df, dircolors, dirname,
  echo, env, expand, expr, factor, false, fmt, fold, hashsum, head, hostname, join, link, ln,
  ls, md5sum, mkdir, mktemp, more, mv, nl, nproc, od, paste, printenv, printf, ptx, pwd,
  readlink, realpath, relpath, rm, rmdir, seq, sha1sum, sha224sum, sha256sum, sha3-224sum,
  sha3-256sum, sha3-384sum, sha3-512sum, sha384sum, sha3sum, sha512sum, shake128sum,
  shake256sum, shred, shuf, sleep, sort, split, sum, sync, tac, tail, tee, test, touch, tr,
  true, truncate, tsort, unexpand, uniq, wc, whoami, yes
"@ -split ',' |
ForEach-Object { $_.trim() } |
Where-Object { ! @('tee', 'sort', 'sleep').Contains($_) } |
ForEach-Object {
    $cmd = $_
    if (Test-Path Alias:$cmd) { Remove-Item -Path Alias:$cmd }
    $fn = '$input | uutils ' + $cmd + ' $args'
    Invoke-Expression "function global:$cmd { $fn }" 
}



# aliases
function Invoke-LS {
  uutils ls -GF --color=auto $args
}

function Invoke-L {
  uutils ls -GF --color=auto -la $args
}

function Invoke-SetItemSwitchable {
  if ($args[0]) {
    Set-Location $args[0]
  } else {
    Invoke-FuzzyZLocation
  }
}

if (Test-PATH env:NVIM_LISTEN_ADDRESS) {
  function Invoke-Nvim {
    $dest = 'chdir "' + (Get-Location).Path.replace("\", "/").replace("C:/Users/nyarla", "~") + '"'
    nvr -cc $dest
    nvr $args
  }

  Set-Alias nvim Invoke-Nvim
}

Remove-Item -Path Alias:cd
Set-Alias cd Invoke-SetItemSwitchable
Set-Alias ls Invoke-LS
Set-Alias l Invoke-L
