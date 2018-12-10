#!/bin/bash
set -e
set -x
pwd
ls -al
docker ps -a
CID=$(docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client)


docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo mkdir -p build"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo mkdir -p build/ServiceBases/cucumber"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo mkdir -p build/ServiceBases/allurereport/kkk"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo mkdir -p build/ServiceBases/junitreport/kkk"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo mkdir -p build/ibservice/"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo mkdir -p build/ibservicexdd/"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo touch  build/ibservicexdd/hhkkjj.txt"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo touch  build/hhkkjj.txt"

#docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 touch -p build"
#docker run -d -p 4040:4040 --link "$CID":http wernight/ngrok ngrok http http:6080 > ./container_idngrok
docker ps -a && sleep 5
sleep 5
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
#echo $(curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh)"/vnc_auto.html"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
docker stop "$CID"
docker rm -f "$CID"