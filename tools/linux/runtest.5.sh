CID=$(docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client)

docker ps -a && sleep 5

docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureReader/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureWriter/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$CID" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
docker stop "$CID"
docker rm "$CID"