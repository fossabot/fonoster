#!/bin/bash

function update() {
  local VERSION COMPOSE_PROJECT_VERSION

  info "Updating Fonoster application... 🚀 "

  execute "cd /out/operator"

  [ -f .env ] || error "You don't have a Fonoster application installed in this directory. Please, install it first."

  VERSION=$FONOSTER_VERSION
  COMPOSE_PROJECT_VERSION=$(grep COMPOSE_PROJECT_VERSION .env | cut -d '=' -f2)

  [ -z "$VERSION" ] && VERSION=$(get_latest_version)
  [ -z "$COMPOSE_PROJECT_VERSION" ] && error "Could not get the current version of Fonoster application."

  info "CURRENT VERSION: $COMPOSE_PROJECT_VERSION | NEW VERSION: $VERSION"

  if [[ "$VERSION" != "$COMPOSE_PROJECT_VERSION" &&
    "$(echo "$VERSION" | cut -d '.' -f1)" == "$(echo "$COMPOSE_PROJECT_VERSION" | cut -d '.' -f1)" &&
    "$(echo "$VERSION" | cut -d '.' -f2)" == "$(echo "$COMPOSE_PROJECT_VERSION" | cut -d '.' -f2)" &&
    "$(echo "$VERSION" | cut -d '.' -f3)" != "$(echo "$COMPOSE_PROJECT_VERSION" | cut -d '.' -f3)" ]]; then

    info "Stop Fonoster application... 🚨 "
    execute "bash ./basic-network.sh down"

    info "Updating Compose version... 🔍 "
    sed -i.bak -e "s#COMPOSE_PROJECT_VERSION=.*#COMPOSE_PROJECT_VERSION=$VERSION#g" ".env"

    info "Starting Fonoster application... 🚀 "
    if [ "$ENABLE_TLS" = "true" ]; then
      execute "bash ./basic-network.sh start"
    else
      execute "bash ./basic-network.sh start-unsecure"
    fi
  else
    info "The application is already up to date. The upgrading only works with a new patch version of your current version."
    info "If it is not the case, please, update your application manually."
  fi
}
