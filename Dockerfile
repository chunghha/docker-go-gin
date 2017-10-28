FROM golang:latest

RUN mkdir -p /app
WORKDIR /app

ADD . /app
RUN go get github.com/gin-gonic/gin
RUN go build ./app.go

EXPOSE 8080

CMD ["./app"]