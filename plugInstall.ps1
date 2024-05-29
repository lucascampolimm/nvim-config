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
            $PlugPath = "$HOME/vimfiles/autoload/plug.vim"
            if (-not (Test-Path $PlugPath)) {
                iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
                ni $PlugPath -Force
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
            $PlugPath = "$nvimPath/nvim-data/site/autoload/plug.vim"

            if (-not (Test-Path $PlugPath)) {
                iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
                ni $PlugPath -Force
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
            $Paths = @("$HOME/vimfiles/autoload/plug.vim",
                        "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim",
                        "$env:XDG_DATA_HOME/nvim-data/site/autoload/plug.vim")
            foreach ($Path in $Paths) {
                if (Test-Path $Path) {
                    Remove-Item $Path -Force
                }
            }
            Write-Host ""
            Write-Host "File plug.vim removed successfully."
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
