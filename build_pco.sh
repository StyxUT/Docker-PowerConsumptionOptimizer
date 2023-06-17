echo "--- Building PCO and pushing image to docker hub ---"
#docker buildx build --platform linux/amd64 --tag styxut/power-consumption-optimizer:latest --load .
docker buildx build --platform linux/amd64 -f ./Dockerfile --tag styxut/power-consumption-optimizer:latest --push .
