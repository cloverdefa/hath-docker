# hath-docker    
    
hath-docker   

This is a H@H client program running on Docker.   
   
Version :   
H@H Client : 1.6.1   
JAVA : OpenJDK-8   
   
### Usage  
You can use the following command to run Docker:
```
docker run \
--name hath \
--net host \
--user <Input Your UID Here>:<Input Your GID Here> \
-v /path/to/your/hath/cache:/hath/cache \
-v /path/to/your/hath/data:/hath/data \ 
-v /path/to/your/hath/download>:/hath/download \
-v /path/to/your/hath/log:/hath/log \
-v /path/to/your/hath/tmp:/hath/tmp \
-e HATH_CLIENT_ID=<Input Your HATH ID Here> \
-e HATH_CLIENT_KEY=<Input Your HATH KEY Here> \
-e UMASK=000 \
cloverdefa/hath:latest
```

Certainly! Here's an example of a docker-compose.yml file that you can use to run the H@H client program:   

### docker-compose.yml (exsample)    
```
version: "3.8"

services:
  hath:  
    image: cloverdefa/hath:latest
    container_name: hath
    user: $UGID
    network_mode: host
    restart: unless-stopped
    volumes:
      - ./cache:/hath/cache
      - ./data:/hath/data  
      - ./download:/hath/download
      - ./log:/hath/log
      - ./tmp:/hath/tmp
    environment:
      HATH_CLIENT_ID: $HATH_CLIENT_ID
      HATH_CLIENT_KEY: $HATH_CLIENT_KEY
      UMASK: 000
```

### if use docker-compose create .env file   
.env (exsample)    

```
UGID: 1000:1000  #change to your UID & GID
HATH_CLIENT_ID: 00000  #change to your client id
HATH_CLIENT_KEY: aaabbbcccddd  #change to your client key

```
   
## Docker Hub

https://hub.docker.com/r/cloverdefa/hath
