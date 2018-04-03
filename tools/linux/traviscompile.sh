#!/bin/bash

set -x
set -e

docker run --detach -e XVFB_RESOLUTION=1920x1080x24 --volume="${PWD}":/home/ubuntu/code onec32/client:${ONECVERSION} client > /tmp/container_id
docker ps && sleep 5
docker exec -u ubuntu "$(cat /tmp/container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 wget -q --continue -O /tmp/oscript.deb http://oscript.io/downloads/night-build/onescript-engine_1.0.20_all.deb  && sudo dpkg -i /tmp/oscript.deb"
docker exec -u ubuntu "$(cat /tmp/container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm install  > /dev/null 2>&1 && sudo opm update -all  > /dev/null 2>&1"
docker exec -u ubuntu "$(cat /tmp/container_id)" /bin/bash -c "cd /home/ubuntu/code; DISPLAY=:1.0 sudo opm run init file --buildFolderPath ./build"
docker stop "$(cat /tmp/container_id)"
