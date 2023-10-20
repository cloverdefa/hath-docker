# hath-docker    
    
hath-docker   

在Docker容器中執行H@H客戶端
   
版本 :   
H@H客戶端版本 : 1.6.2   
   
### Usage  
執行以下指令來運作容器:
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

你也能夠使用docker-compose來運作容器:   

### docker-compose.yml範例    
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

### 如果你使用docker-compose來運作容器，推薦你建立.env檔案來保存你的ID以及KEY   
.env (範例)    

```
UGID: 1000:1000    #  變更 1000:1000 為你的 UID:GID
HATH_CLIENT_ID: 00000    #  變更 00000 為你的 client id
HATH_CLIENT_KEY: aaabbbccc    #  變更 aaabbbccc 為你的 client key

```
變更.env檔案權限   
chmod 600 .env   
   
## Docker Hub

https://hub.docker.com/r/cloverdefa/hath
