#!/bin/sh
docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:latest client > ./container_id
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/StepsRunner/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run vanessa all --path ./features/Core/FeatureLoad/ --settings ./tools/JSON/VBParams8310linux.json"
docker exec -u ubuntu "$(cat ./container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo chown -R 114 ./"
