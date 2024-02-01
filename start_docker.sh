if [ ! "$(docker ps --all --quiet --filter name=tosbaja_docs)" ]; then
    echo "No container found as tosbaja_docs creating tosbaja_docs and executing it."
    docker run -it --user $USERNAME \
        -v $(pwd):/home/$USERNAME/docs \
        --name tosbaja_docs \
        tosbaja:docs \
        /bin/bash
else
    if [ ! "$(docker ps --all --quiet --filter name=tosbaja_docs --filter status=running)" ]; then
        echo "Container tosbaja_docs found but is not running, starting tosbaja_docs and executing it."
        docker start tosbaja_docs
        docker exec -it  tosbaja_docs /bin/bash
    else
        echo "Container tosbaja_docs found and is running. Executing container."
        docker exec -it  tosbaja_docs /bin/bash
    fi
fi