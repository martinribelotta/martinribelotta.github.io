param(
    [string]$CommitMessage = "Deploy site $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Invoke-Checked {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,
        [Parameter(Mandatory = $true)]
        [string]$ErrorMessage
    )

    Invoke-Expression $Command
    if ($LASTEXITCODE -ne 0) {
        throw "$ErrorMessage (exit code: $LASTEXITCODE)"
    }
}

$repoRoot = (git rev-parse --show-toplevel).Trim()
if (-not $repoRoot) {
    throw 'No se pudo detectar la raiz del repositorio Git.'
}

Push-Location $repoRoot

$publishWorktree = Join-Path $repoRoot '.publish-master'
$enteredPublishWorktree = $false

try {
    Write-Host '1) Compilando sitio con Hugo...'
    Invoke-Checked -Command 'hugo --minify' -ErrorMessage 'Fallo la compilacion de Hugo'

    if (-not (Test-Path (Join-Path $repoRoot 'public'))) {
        throw 'No existe la carpeta public luego de compilar.'
    }

    Write-Host '2) Preparando worktree temporal de master...'
    if (Test-Path $publishWorktree) {
        git worktree remove --force $publishWorktree | Out-Null
    }

    git show-ref --verify --quiet refs/heads/master
    if ($LASTEXITCODE -eq 0) {
        Invoke-Checked -Command "git worktree add --force `"$publishWorktree`" master" -ErrorMessage 'No se pudo crear la worktree de master'
    }
    else {
        Invoke-Checked -Command "git worktree add --force -b master `"$publishWorktree`" origin/master" -ErrorMessage 'No se pudo crear la rama master desde origin/master'
    }

    Write-Host '3) Sincronizando public hacia master...'
    Push-Location $publishWorktree
    $enteredPublishWorktree = $true

    Invoke-Checked -Command 'git fetch origin master' -ErrorMessage 'No se pudo actualizar referencias de origin/master'
    Invoke-Checked -Command 'git merge --ff-only origin/master' -ErrorMessage 'No se pudo fast-forward master con origin/master'

    Get-ChildItem -Force | Where-Object { $_.Name -ne '.git' } | Remove-Item -Recurse -Force

    $sourcePublic = Join-Path $repoRoot 'public'
    $robocopyOutput = & robocopy $sourcePublic $publishWorktree /E /NFL /NDL /NJH /NJS /NP
    $robocopyExit = $LASTEXITCODE
    if ($robocopyExit -gt 7) {
        throw "Robocopy fallo con codigo $robocopyExit"
    }
    $null = $robocopyOutput

    Write-Host '4) Commit y push a master...'
    git add -A
    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Write-Host 'No hay cambios para publicar en master.'
    }
    else {
        git commit -m $CommitMessage
        Invoke-Checked -Command 'git push origin master' -ErrorMessage 'Fallo el push a origin/master'
        Write-Host 'Deploy completado con exito.'
    }
}
finally {
    if ($enteredPublishWorktree) {
        Pop-Location
    }
    $worktreeGitFile = Join-Path $publishWorktree '.git'
    if (Test-Path $worktreeGitFile) {
        & git worktree remove --force $publishWorktree *> $null
    }
    elseif (Test-Path $publishWorktree) {
        Remove-Item -Recurse -Force $publishWorktree
    }
    Pop-Location
}
