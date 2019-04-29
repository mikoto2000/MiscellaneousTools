Set-Alias dc docker-compose

# ColorTool がインストール済みならそれを使ってコンソールの色設定を行う
if (Get-Command('ColorTool.exe') -ErrorAction SilentlyContinue) {
    ColorTool.exe -q OneHalfDark
}

