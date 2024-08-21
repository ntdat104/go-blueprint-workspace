FROM golang:1.22.4-alpine as builder
WORKDIR /app
COPY . /app

ENV BUILD_TAG 1.0.0
ENV GO111MODULE on
ENV CGO_ENABLED=0
ENV GOOS=linux

RUN go mod vendor
RUN go build -o server cmd/api/main.go

# stage2.1: rebuild
FROM alpine
WORKDIR /app
COPY --from=builder /app/server /app/server.go
CMD ["./server.go"]