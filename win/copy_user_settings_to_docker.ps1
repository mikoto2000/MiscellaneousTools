# copy_user_settings_to_docker.ps1
#
# �z�X�g�̐ݒ�� docker �R���e�i�ɃR�s�[���܂��B
#
# �R�s�[�Ώ�:
#     - $HOME/.gitconfig
#     - $HOME/.ssh
#     - $HOME/.gem/credentials
# ����:
#     container: �R���e�i���܂��̓R���e�i ID
Param( [string]$container )

if ([String]::IsNullOrEmpty($container)) {
    Write-Error "'container' ���ݒ肳��Ă��܂���B �������ɃR���e�i���܂��̓R���e�i ID ���w�肵�Ă��������B"
    return 1
}

docker cp "$HOME\.gitconfig" "${container}:/root"
docker cp "$HOME\.ssh" "${container}:/root"
docker cp "$HOME\.gem" "${container}:/root"
docker exec ${container} chmod 0600 /root/.gem/credentials
docker exec ${container} chmod 0700 /root/.ssh
docker exec ${container} chmod 0600 /root/.ssh/id_rsa

