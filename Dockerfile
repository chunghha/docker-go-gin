ARG GO_VERSION=1.11

FROM golang:${GO_VERSION}-alpine AS builder

RUN apk update && apk add alpine-sdk git && rm -rf /var/cache/apk/*

RUN go get github.com/gin-gonic/gin
RUN go get github.com/jinzhu/gorm
RUN go get github.com/mattn/go-sqlite3

RUN mkdir -p /api
WORKDIR /api
ADD . /api
RUN go build ./app.go

FROM alpine:latest

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /api
WORKDIR /api
COPY --from=builder /api/app .
COPY --from=builder /api/test.db .

EXPOSE 8080

ENTRYPOINT ["./app"]