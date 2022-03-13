Set-Alias dc docker-compose

function dr() {
    docker run -it --rm $args
}

function drv() {
    docker run -it --rm -v "$(pwd):/work" --workdir="/work" $args
}

# ColorTool がインストール済みならそれを使ってコンソールの色設定を行う
if (Get-Command('ColorTool.exe') -ErrorAction SilentlyContinue) {
    ColorTool.exe -q OneHalfDark
}

