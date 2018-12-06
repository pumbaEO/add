#!/usr/bin/bash
set -x
docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client > ./container_id
#docker run -d -p 4040:4040 --link "$(cat ./container_id)":http wernight/ngrok ngrok http http:6080 > ./container_idngrok
docker ps -a && sleep 5
#sleep 5 && echo $(curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh)"/vnc_auto.html"
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo pm build ./"
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
docker stop "$CID"
docker rm "$CID"