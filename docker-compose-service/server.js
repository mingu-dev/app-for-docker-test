const express = require("express");
const redis = require("redis");

// redis client 생성
// 도커 환경에서는 host에 컨테이너 이름을 넣어준다.
const client = redis.createClient({
    host: "redis-server",
    port: 6379
})

const app = express();

// 접속할 때마다 숫자가 1씩 올라가는 app
client.set("number", 0);
app.get('/', (req, res) => {
    client.get("number", (err, number) => {
        client.set("number", parseInt(number)+1)
        res.send("숫자가 1씩 올라갑니다. 숫자: " + number)
    })
})

app.listen(8080);

console.log('Server is running.');