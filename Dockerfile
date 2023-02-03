
FROM golang:alpine AS builder

ENV GO111MODULE=on \
  CGO_ENABLED=0 \
  GOOS=linux \
  GOARCH=amd64

WORKDIR /build

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o main .


FROM scratch

COPY --from=builder /build/main /

EXPOSE 3000

ENTRYPOINT ["/main"]