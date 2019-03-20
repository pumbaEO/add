#!/usr/bin/bash
set -x
CID=$(docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client)
#docker run -d -p 4040:4040 --link "$CID":http wernight/ngrok ngrok http http:6080 > ./container_idngrok
docker ps -a && sleep 5
#sleep 5 && echo $(curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh)"/vnc_auto.html"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/TestClient/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/StepsGenerator/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 1000 ./"
docker stop "$CID"
docker rm "$CID"