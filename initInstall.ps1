# Description: Automation to copy the configuration file to the correct location.

Clear-Host

$exit = $false

while(-not $exit) {
    Write-Host "Choose an editor to copy the configuration file: "
    Write-Host ""
    Write-Host "1) Vim"
    Write-Host "2) Neovim"
    Write-Host "3) Exit"
    Write-Host ""

    Write-Host -NoNewline ">> "
    $op = [Console]::ReadLine()

    switch ($op) {
        '1' {
            $initPath = "$HOME/.vimrc"
            if (-not (Test-Path $initPath)) {
                Copy-Item -Path "init.vim" -Destination "$HOME" -Force
                Rename-Item -Path "$HOME/init.vim" -NewName ".vimrc" -Force
                Write-Host ""
                Write-Host "The configuration file has been copied."
            } else {
                Write-Host ""
                Write-Host "The file .vimrc already exists!"
            }
            $exit = $true
            break
        }
        '2' {
            $nvimPath = $null
            if ($env:XDG_DATA_HOME) {
                $nvimPath = $env:XDG_DATA_HOME
                } else {
                    $nvimPath = $env:LOCALAPPDATA
                }

            $initPath = "$nvimPath/nvim/init.vim"
            if (-not (Test-Path $initPath)) {
                $nvimDir = Join-Path -Path $nvimPath -ChildPath "nvim"
                if (-Not (Test-Path -Path $nvimDir)) {
                    New-Item -ItemType Directory -Path $nvimDir
                }

                Copy-Item -Path "init.vim" -Destination $nvimDir -Force
                Write-Host ""
                Write-Host "The configuration file has been copied."
            } else {
                Write-Host ""
                Write-Host "The file init.vim already exists!"
            }
            $exit = $true
            break
        }
        '3' {
            Write-Host ""
            Write-Host "You have chosen to exit."
            $exit = $true
            break
        }
        default {
            Clear-Host
            Write-Host "Invalid option!"
            Write-Host ""
        }
    }
}
