FROM node:10

# 관련된 파일들을 특정한 working directory에 모아놓는다.
WORKDIR /usr/src/app

# npm이 종속성을 다운로드 받기 전에 종속성 관리 파일인 package.json만 copy한다. 
# 소스만 변경되었을 때는 종속성 다운로드가 캐싱 처리되어서 빌드 속도가 빨라지도록 만든다.
# 소스 파일(server.js)를 npm install 전에 copy하면 docker가 변경을 감지하여 변경되지 않은 종속성들을 캐싱 처리하지 않고 새로 다운로드 받는다.
COPY package.json ./

RUN npm install

# 종속성 다운로드가 완료된 후, 소스 파일을 copy 한다.
COPY ./ ./

CMD [ "node", "server.js" ]

# docker build -t mingukangkor/nodejs-app ./

# docker run -d -p 5000:8080 -v /usr/src/app/node_modules -v ${pwd}:/usr/src/app docker.io/mingukangkor/nodejs-app