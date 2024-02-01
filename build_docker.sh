GID=$(id -g $USERNAME)
echo The gid of crrent user is $GID.
echo The uid of crrent user is $UID.
echo The username of crrent user is $USERNAME.
sudo docker build --build-arg USERNAME=$USERNAME --build-arg USER_GID=$GID --build-arg USER_UID=$UID -t tosbaja:docs .
