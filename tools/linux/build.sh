#!/bin/bash
pwd
#ls -al
#docker ps -a
CID=$(docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client)

CIDN=$(docker run -d -p 4040:4040 --link "${CID}":http wernight/ngrok ngrok http http:6080 )
#docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 touch -p build"
sleep 5

echo $(curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh)""
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm install vanessa-runner"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm update -all"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/manually/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/StepsGenerator/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureLoad/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/StepsProgramming/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureReader/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /homPe/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureWriter/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureReader/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureWriter/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureReader/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureWriter/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/StepsRunner/ --settings ./tools/JSON/VBParams8310linux.json"
# docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureLoad/ --settings ./tools/JSON/VBParams8310linux.json"



docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 touch -p build"
 #docker run -d -p 4040:4040 --link "$CID":http wernight/ngrok ngrok http http:6080 > ./container_idngrok
#docker ps -a && sleep 5
#sleep 5
#docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
#echo $(curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh)"/vnc_auto.html"
#docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
docker stop "$CID"
docker rm -f "$CID"
docker stop "$CIDN"
docker rm -f "$CIDN"