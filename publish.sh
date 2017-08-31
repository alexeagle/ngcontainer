set -e

TAG=$1
if [ -z $TAG ]
  then echo "usage: $0 [tag]"; exit 1
fi

docker build . -t angular/ngcontainer:$TAG
docker push angular/ngcontainer
git tag -a $TAG -m "published to docker"
git push --tags
