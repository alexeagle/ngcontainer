set -e

TAG=$1
if [ -z $TAG ]
  then echo "usage: $0 [tag]"; exit 1
fi

docker build --file=Dockerfile.workaround4947  . -t angular/ngcontainer:$TAG
docker tag angular/ngcontainer:$TAG angular/ngcontainer:latest
docker push angular/ngcontainer:$TAG
docker push angular/ngcontainer:latest
git tag -a $TAG -m "published to docker"
git push --tags
