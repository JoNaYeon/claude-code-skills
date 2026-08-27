<#
.SYNOPSIS
  이 레포로 작업할 환경을 만든다 (.ai/bootstrap.sh 래퍼).

.DESCRIPTION
  하네스 스크립트는 bash 로 쓰여 있다. bash 를 찾아 같은 부트스트랩을 돌리고 종료 코드를
  그대로 돌려준다. 로직은 여기 두지 않는다 — 두 곳에 나뉘면 한쪽만 고쳐진다.
#>

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$target = Join-Path $here 'bootstrap.sh'
if (-not (Test-Path $target)) { Write-Error "bootstrap.sh 가 없다: $target"; exit 1 }

$bash = (Get-Command bash -ErrorAction SilentlyContinue).Source
if (-not $bash) {
  foreach ($c in @("$env:ProgramFiles\Git\bin\bash.exe", "${env:ProgramFiles(x86)}\Git\bin\bash.exe")) {
    if (Test-Path $c) { $bash = $c; break }
  }
}
if (-not $bash) {
  Write-Error "bash 를 찾지 못했다. Git for Windows 를 설치하거나 bash 를 PATH 에 넣어라."
  exit 1
}

& $bash $target @args
exit $LASTEXITCODE
