docker build --build-arg REGISTRY=$1 -t "$1/testimg:1" .
docker push $1/testimg:1