FROM golang:1.21-alpine as builder

WORKDIR /app
COPY . .

#RUN go mod init github.com/hieuocb/go-k8s.git
RUN CGO_ENABLED=0 GOOS=linux go build -o go-k8s

FROM alpine:3.19.1

WORKDIR /app
COPY --from=builder /app/go-k8s/ /app/

EXPOSE 8080
CMD ["/app/go-k8s"]