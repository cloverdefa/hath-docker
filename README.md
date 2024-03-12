# hath-docker    
    
hath-docker   

在Docker容器中執行H@H客戶端
   
版本 :   
H@H客戶端版本 : 1.6.2   
   
### Usage  
使用docker來運作容器:
```
docker run \
--name hath \
--net host \
--user ${UID}:${GID} \
-v /本地cache路徑:/hath/cache \
-v /本地data路徑:/hath/data \ 
-v /本地download路徑:/hath/download \
-v /本地log路徑:/hath/log \
-v /本地tmp路徑:/hath/tmp \
-e HATH_CLIENT_ID=輸入你的HATH ID \
-e HATH_CLIENT_KEY=輸入你的HATH KEY \
-e UMASK=000 \
cloverdefa/hath:latest
```

使用docker-compose來運作容器:   

### docker-compose.yml範例    
```
version: "3.9"

services:
  hath:
    container_name: hath
    image: cloverdefa/hath:latest
    restart: unless-stopped
    networks:
      - hath-networks
    prots:
      - 12345:12345 # 修改為HATH設定PORT
    user: ${ID} # .env內ID:設定UID及GID
    volumes:
      - ./cache:/hath/cache
      - ./data:/hath/data
      - ./download:/hath/download
      - ./log:/hath/log
      - ./tmp:/hath/tmp
    environment:
      # 編輯同路徑資料夾下的.env檔案來設定ID及KEY   
      HATH_CLIENT_ID: $(HATH_CLIENT_ID)
      HATH_CLIENT_KEY: $(HATH_CLIENT_KEY)
      UMASK: '000'
      TZ: 'Asia/Taipei' # 設定主機所在時區

netwroks:
  hath-networks:
    name: "hath-networks"
```

建立.env檔案存放ID及KEY
### .env(範例)   
```
ID: 'UID:GID'
HATH_CLIENT_ID: ‘ID’    #  修改ID為你的 H@H client id   
HATH_CLIENT_KEY: ‘KEY’    #  修改KEY為你的 H@H client key   
```
變更.env檔案權限   
chmod 600 .env   
   
## Docker Hub

https://hub.docker.com/r/cloverdefa/hath
