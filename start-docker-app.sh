#!/bin/bash

# Check if Docker Desktop is running
if ! (powershell.exe -c "Get-Process 'Docker Desktop'" > /dev/null 2>&1); then
  echo "Starting Docker Desktop..."
  powershell.exe -c "Start-Process 'C:\Program Files\Docker\Docker\Docker Desktop.exe'"
  echo "Waiting for Docker Desktop to start..."
  while ! (powershell.exe -c "Get-Process 'Docker Desktop'" > /dev/null 2>&1); do
    sleep 1
  done
  echo "Docker Desktop is running."
fi

# Wait for Docker daemon to be ready
echo "Waiting for Docker daemon to be ready..."
while ! (docker version > /dev/null 2>&1); do
  sleep 1
done
echo "Docker daemon is ready."

# Run docker-compose up --build
echo "Building and starting the Docker container..."
docker-compose up --build &

# Wait for the container to be ready
echo "Waiting for the application to be ready..."
while ! (curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 -m 5 | grep -q "200\|201\|202\|203\|204\|205\|206"); do
  sleep 1
done

# Open the browser to http://localhost:3000
echo "Opening the browser to http://localhost:3000..."
powershell.exe -c "Start-Process 'http://localhost:3000'"
