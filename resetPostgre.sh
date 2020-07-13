#!/bin/bash
# Script to Reset Postgre for Vapor Dev

echo "Stop PostgreSQL:"
docker stop postgres

echo "Remove PostgreSQL:"
docker rm postgres

echo "Construct PostgreSQL:"
docker run --name postgres -e POSTGRES_DB=mydb -e POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypass -p 5432:5432 -d postgres


echo "DB_URL=postgres://myuser:mypass@localhost:5432/mydb"
