# login previo
echo $GHCR_PAT | docker login ghcr.io -u $GHCR_USERNAME --password-stdin
docker-compose up -d
