#!/bin/bash

PROJECT_NAME="cloud-simulator"
SQL_DUMP_PATH="./config/directus.sql"
PG_CONTAINER="${PROJECT_NAME}_postgres_1"
DIRECTUS_CONTAINER="${PROJECT_NAME}_directus_1"
FRONTEND_PORT=8080
DIRECTUS_PORT=8055

function start_project() {
    echo "🚀 Starting $PROJECT_NAME stack..."
    docker-compose up --build -d

    echo "✅ Directus is up!"
    echo "🌐 Access Directus: http://localhost:$DIRECTUS_PORT"
    echo "🌐 Access Frontend: http://localhost:$FRONTEND_PORT"
}

function stop_project() {
    echo "🛑 Stopping $PROJECT_NAME stack..."

    echo "📦 Dumping Directus database to $SQL_DUMP_PATH..."
    docker exec $PG_CONTAINER pg_dump -U directus directus > $SQL_DUMP_PATH

    echo "🧹 Shutting down containers..."
    docker-compose down

    echo "✅ Project stopped and database saved."
}

case "$1" in
    (start)
        start_project
        ;;
    (stop)
        stop_project
        ;;
    (*)
        echo "Usage: ./launchProject.sh {start|stop}"
        exit 1
        ;;
esac
