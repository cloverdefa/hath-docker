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
--user <你的UID>:<你的GID> \
-v /path/to/your/hath/cache:/hath/cache \
-v /path/to/your/hath/data:/hath/data \ 
-v /path/to/your/hath/download>:/hath/download \
-v /path/to/your/hath/log:/hath/log \
-v /path/to/your/hath/tmp:/hath/tmp \
-e HATH_CLIENT_ID=<輸入你的HATH ID> \
-e HATH_CLIENT_KEY=<輸入你的HATH KEY> \
-e UMASK=000 \
cloverdefa/hath:latest
```

你也能夠使用docker-compose來運作容器:   

### docker-compose.yml範例    
```
version: "3.9"   
   
services:   
  hath:   
    container_name: hath   
    image: cloverdefa/hath:latest   
    restart: unless-stopped   
    network_mode: host   
    user: '${UID}:${GID}'   
    volumes:   
      - ./cache:/hath/cache   
      - ./data:/hath/data   
      - ./download:/hath/download   
      - ./log:/hath/log   
      - ./tmp:/hath/tmp   
    environment:   
      HATH_CLIENT_ID: ${HATH_CLIENT_ID} # 使用 .env 內設定的 H@H Client ID   
      HATH_CLIENT_KEY: ${HATH_CLIENT_KEY} # 使用 .env 內設定的 H@H Client KEY   
      UMASK: '000'   
      TZ: 'Asia/Taipei' # 設定主機所在時區   
```

如果你使用docker-compose來運作容器，推薦你建立.env檔案來保存你的ID以及KEY  
### .env(範例)   
```
ID: 1000:100  #  設定你的 UID:GID  
HATH_CLIENT_ID: 00000    #  設定你的 H@H client id   
HATH_CLIENT_KEY: aaabbbccc    #  設定你的 H@H client key   
```
變更.env檔案權限   
chmod 600 .env   
   
## Docker Hub

https://hub.docker.com/r/cloverdefa/hath
