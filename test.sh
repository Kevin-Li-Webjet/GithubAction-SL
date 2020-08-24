docker build --build-arg REGISTRY=$1 -t "testimg:1" .
docker push $1/testimg:1