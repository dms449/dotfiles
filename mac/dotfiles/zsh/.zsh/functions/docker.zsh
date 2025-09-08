docker_or_local() {
  local image=""
  local default_image="web"

  if [[ -f docker-compose.yml ]]; then
    if [[ -f .docker_or_local ]]; then
      local command=$(echo $1 | cut -d' ' -f1)
      local config=$(grep "$command=" .docker_or_local)
      local image=$(echo $config | cut -d= -f2)
    fi

    if [[ $image == "" ]]; then
      local image=$default_image
    fi
  fi

  if [[ $image == "" ]]; then
    eval {"SKIP_SIMPLECOV=true $@"}
  else
    eval {"docker compose run --rm --no-deps -e SKIP_SIMPLECOV=true $image /bin/bash -c \"$@\""}
  fi
}

cup() {
  docker compose up
}

docker_cleanup() {
    echo "🧹 Starting Docker cleanup..."

    # Stop all running containers first
    echo "Stopping all running containers..."
    docker stop $(docker ps -q) 2>/dev/null || echo "No running containers to stop"

    # Remove all containers
    echo "Removing all containers..."
    docker rm $(docker ps -aq) 2>/dev/null || echo "No containers to remove"

    # Remove all volumes
    echo "Removing all volumes..."
    docker volume rm $(docker volume ls -q) 2>/dev/null || echo "No volumes to remove"

    # Remove all images
    echo "Removing all images..."
    docker rmi $(docker images -aq) 2>/dev/null || echo "No images to remove"

    # Clean up any remaining artifacts
    echo "Running docker system prune..."
    docker system prune -af --volumes

    echo "✅ Docker cleanup complete!"
}
