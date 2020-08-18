# copy_user_settings_to_docker.ps1
#
# ホストの設定を docker コンテナにコピーします。
#
# コピー対象:
#     - $HOME/.gitconfig
#     - $HOME/.ssh
#     - $HOME/.gem/credentials
# 引数:
#     container: コンテナ名またはコンテナ ID
Param( [string]$container )

if ([String]::IsNullOrEmpty($container)) {
    Write-Error "'container' が設定されていません。 第一引数にコンテナ名またはコンテナ ID を指定してください。"
    return 1
}

docker cp "$HOME\.gitconfig" "${container}:/root"
docker cp "$HOME\.ssh" "${container}:/root"
docker cp "$HOME\.gem" "${container}:/root"
docker exec ${container} chmod 0600 /root/.gem/credentials
docker exec ${container} chmod 0700 /root/.ssh
docker exec ${container} chmod 0600 /root/.ssh/id_rsa

