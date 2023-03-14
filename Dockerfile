##
## Build
##

FROM golang:1.20-alpine3.17 AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

# Base package
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -a -o deterministic-zip main.go


##
## Deploy
##

FROM alpine:3.17

WORKDIR /

COPY --from=build /app/deterministic-zip /deterministic-zip

ENTRYPOINT ["/deterministic-zip"]
