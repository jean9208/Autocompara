docker ps -a -q | xargs -n 1 -P 8 -I {} docker stop {}