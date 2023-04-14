FROM golang:1.20.3 AS builder

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/github.com/n123tw/netology-sysadm-cicd-1
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app .

FROM alpine:latest
RUN apk -U add ca-certificates
COPY --from=builder /app /app
CMD ["/app"]
