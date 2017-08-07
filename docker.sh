## ssh into a docker container
function b_docker_ssh() {
    if [ -z "$1" ];
        then
            echo "$USER, give me a processes ID mate!"
        else
            docker exec -it $1 bash
    fi
}