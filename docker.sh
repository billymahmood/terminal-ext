#!/bin/zsh
##
##  This is a custom Docker helper functions file for Zsh.
##  Inspired by a request from SuperHumanRoid.
##  Prefix: b_docker_
##

# -----------------------------------------------------------------------------
# -- Container Management
# -----------------------------------------------------------------------------

## Get a shell inside a running container.
## Tries bash first, then falls back to sh for alpine/minimal images.
## Usage: b_docker_shell <container_name_or_id>
b_docker_shell() {
  if (( $# == 0 )); then
    echo "Error: Please provide a container name or ID." >&2
    return 1
  fi
  # Use || to fall back to sh if bash is not found
  docker exec -it "$1" bash || docker exec -it "$1" sh
}

## List all RUNNING containers.
## Usage: b_docker_ps
b_docker_ps() {
  echo "🐳 --- Running Containers ---"
  docker ps
}

## List ALL containers (running and stopped).
## Usage: b_docker_psa
b_docker_psa() {
  echo "🐳 --- All Containers ---"
  docker ps -a
}

## Stop a specific container.
## Usage: b_docker_stop <container_name_or_id>
b_docker_stop() {
  if (( $# == 0 )); then
    echo "Error: Please provide a container name or ID to stop." >&2
    return 1
  fi
  echo "🛑 Stopping container: $1"
  docker stop "$1"
}

## Stop ALL running containers.
## Usage: b_docker_stop_all
b_docker_stop_all() {
  local running_containers=$(docker ps -q)
  if [[ -z "$running_containers" ]]; then
    echo "No containers are currently running."
    return 0
  fi
  echo "🛑 Stopping all running containers..."
  # xargs is great for passing a list of items as arguments to another command
  docker ps -q | xargs docker stop
}

# -----------------------------------------------------------------------------
# -- Logs & Images
# -----------------------------------------------------------------------------

## View the logs of a container.
## Usage: b_docker_logs <container_name_or_id>
b_docker_logs() {
  if (( $# == 0 )); then
    echo "Error: Please provide a container name or ID to see its logs." >&2
    return 1
  fi
  docker logs "$1"
}

## Follow the logs of a container in real-time. (Like `tail -f`)
## Usage: b_docker_logs_f <container_name_or_id>
b_docker_logs_f() {
  if (( $# == 0 )); then
    echo "Error: Please provide a container name or ID to follow its logs." >&2
    return 1
  fi
  docker logs -f "$1"
}

## List all Docker images on the system.
## Usage: b_docker_images
b_docker_images() {
  echo "🖼️  --- Docker Images ---"
  docker images
}


# -----------------------------------------------------------------------------
# -- System & Cleanup
# -----------------------------------------------------------------------------

## Remove a specific container.
## Note: The container must be stopped first.
## Usage: b_docker_rm <container_name_or_id>
b_docker_rm() {
  if (( $# == 0 )); then
    echo "Error: Please provide a container name or ID to remove." >&2
    return 1
  fi
  echo "🗑️  Removing container: $1"
  docker rm "$1"
}

## Remove all STOPPED containers.
## Usage: b_docker_prune_containers
b_docker_prune_containers() {
  echo "🧹 Cleaning up stopped containers..."
  docker container prune -f
}

## A more aggressive cleanup: removes all stopped containers, unused networks,
## and dangling images.
## Usage: b_docker_prune
b_docker_prune() {
  echo "🧹 Pruning system: removing stopped containers, unused networks, and dangling images..."
  docker system prune -f
}

## ⚠️ DANGEROUS ⚠️: The ultimate cleanup.
## Removes everything that is not associated with a running container.
## This includes stopped containers, all unused networks, build cache,
## and ALL unused images (not just dangling ones).
## Usage: b_docker_prune_all
b_docker_prune_all() {
  echo "☢️  --- WARNING: Aggressive System Prune --- ☢️"
  echo "This will remove:"
  echo "  - All stopped containers"
  echo "  - All build cache"
  echo "  - All unused networks"
  echo "  - All unused images (not just dangling ones)"
  # Zsh-style confirmation prompt
  read -q "REPLY?Are you sure you want to continue? (y/n) "
  echo "" # Add a newline for cleaner output
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "🧹 Proceeding with full system prune..."
    docker system prune -af
  else
    echo "Prune cancelled."
  fi
}