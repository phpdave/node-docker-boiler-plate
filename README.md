1. Install WSL2: https://docs.microsoft.com/en-us/windows/wsl/install
2. Install Docker Desktop with WSL2 support: https://docs.docker.com/docker-for-windows/wsl/
3. In WSL2 navigate to the project and run ```chmod +x start-docker-app.sh```
4. Run the shell script that builds the docker and starts the application up and opens the browser to the app.

```
./start-docker-app.sh
```

1. add an entry to your host file
127.0.0.1 local_reverse_proxy_my_app

2. Rename frontend/.env.sample to frontend/.env .  Then inside the file set your username and password for the DB2

3. This is to start up docker
```
docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" && docker-compose up
docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" && docker-compose up
```

4. Test the frontend https://local_reverse_proxy_my_app:4203
curl --insecure https://local_reverse_proxy_my_app:4203

5. Test the backend service:
```
curl --insecure https://local_reverse_proxy_my_app:4201
```
expected output: {"status":"ok","data":{"message":"hello world"}}

Replace cookie value with your cookie value from authenticating with Azure.  Expected result is your user info
```
curl --insecure --cookie "my-app-ad-auth=<cookie value>" https://local_reverse_proxy_my_app:4201/auth/user
```

6. Set USER_ID, USER_PASSWORD, DSN, NODE_ENV in .env file
```
If local, use DockerProductionDSN
If on IBMi, use IBMiProductionDSN
```