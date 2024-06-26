# Description: Automation to install Vim Plug Package Manager on Windows.

Clear-Host

$exit = $false

while(-not $exit) {
    Write-Host "Choose an editor to configure Vim Plug: "
    Write-Host ""
    Write-Host "1) Vim"
    Write-Host "2) Neovim"
    Write-Host "3) Uninstall"
    Write-Host "4) Exit"
    Write-Host ""

    Write-Host -NoNewline ">> "
    $op = [Console]::ReadLine()

    switch ($op) {
        '1' {  
            $plugPath = "$HOME/vimfiles/autoload/plug.vim"
            if (-not (Test-Path $plugPath)) {
                iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
                ni $plugPath -Force
                Write-Host ""
                Write-Host "Vim Plug configuration completed."
            } else {
                Write-Host ""
                Write-Host "The file plug.vim already exists!"
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
            $plugPath = "$nvimPath/nvim-data/site/autoload/plug.vim"

            if (-not (Test-Path $plugPath)) {
                iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
                ni $plugPath -Force
                Write-Host ""
                Write-Host "Vim Plug configuration completed."
            } else {
                Write-Host ""
                Write-Host "The file plug.vim already exists!"
            }
            $exit = $true
            break
        }
        '3' {
            Write-Host ""
            $response = Read-Host "Are you sure you want to remove the plug.vim file? (Y/N)"
            if ($response -eq "Y" -or $response -eq "y") {
                $paths = @("$HOME/vimfiles/autoload/plug.vim",
                            "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim",
                            "$env:XDG_DATA_HOME/nvim-data/site/autoload/plug.vim")
                $plugFound = $false
                foreach ($Path in $paths) {
                    if (Test-Path $Path) {
                        Remove-Item $Path -Force
                        $plugFound = $true
                    }
                }
                if (-not $plugFound) {
                    Write-Host ""
                    Write-Host "File plug.vim not found in any directory."
                    } else {
                        Write-Host ""
                        Write-Host "File plug.vim removed successfully."
                    }
            } else {
                Write-Host ""
                Write-Host "Operation cancelled."
            }
            $exit = $true
            break
        }
        '4' {
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
