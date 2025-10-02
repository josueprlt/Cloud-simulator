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

    echo "⏳ Waiting for PostgreSQL..."
    sleep 5

    echo "📥 Seeding database from $SQL_DUMP_PATH..."
    docker exec -i $PG_CONTAINER psql -U directus directus < "$SQL_DUMP_PATH" &>/dev/null
    cd app/ && yarn install

    echo "✅ Database seeded"
    echo "🌐 Directus: http://localhost:$DIRECTUS_PORT"
    echo "🌐 Frontend: http://localhost:$FRONTEND_PORT"
}

function stop_project() {
    echo "🛑 Stopping $PROJECT_NAME stack..."

    echo "📦 Overwriting $SQL_DUMP_PATH with current database state..."
    docker exec $PG_CONTAINER pg_dump -U directus directus > "$SQL_DUMP_PATH"

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
