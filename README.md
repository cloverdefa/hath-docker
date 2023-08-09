# hath-docker    
    
hath-docker   

This is a H@H client program running on Docker.   
   
Version :   
H@H Client : 1.6.1   
JAVA : openjdk-build 22-ea+9-633   
Bookworm-slim
   
## Usage  
You can use the following command to run Docker:
```
docker run \
--name hath \
--user <Input Your UID Here>:<Input Your GID Here> \
-v /path/to/your/hath/cache:/hath/cache \
-v /path/to/your/hath/data:/hath/data \ 
-v /path/to/your/hath/download>:/hath/download \
-v /path/to/your/hath/log:/hath/log \
-v /path/to/your/hath/tmp:/hath/tmp \
-e HATH_CLIENT_ID=<Input Your HATH ID Here> \
-e HATH_CLIENT_KEY=<Input Your HATH KEY Here> \
-e UMASK=000 \
-e TZ=<Input YOUR_TIMEZONE Here> \
-p <YOUR_HATH_PORT>/tcp \
cloverdefa/hath:latest
```

Certainly! Here's an example of a docker-compose.yml file that you can use to run the H@H client program:   
```
version: "3.8"

services:
  hath:  
    image: cloverdefa/hath:latest
    container_name: 'hath'
    user: '<Input Your UID Here>:<Input Your GID Here>'
    network_mode: 'host'
    volumes:
      - ./cache:/hath/cache
      - ./data:/hath/data  
      - ./download:/hath/download
      - ./log:/hath/log
      - ./tmp:/hath/tmp
    environment:
      HATH_CLIENT_ID: '<Input Your HATH ID Here>'
      HATH_CLIENT_KEY: '<Input Your HATH KEY Here>'
      UMASK: '000'
      TZ: '<Input Your TimeZone Here>'
    restart: 'unless-stopped'
```
   
## Docker Hub

https://hub.docker.com/r/cloverdefa/hath
