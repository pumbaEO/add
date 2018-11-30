docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client > ./container_id1

docker ps -a && sleep 5

docker exec -u ubuntu "$(cat ./container_id1)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$(cat ./container_id1)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureReader/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$(cat ./container_id1)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureWriter/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown 114:118-r ./"
