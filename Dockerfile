##
## Build
##

FROM golang:1.19-alpine3.17 AS build

ARG GitSha Version BuildTime

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

# Base package
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o deterministic-zip -ldflags \
        "-X github.com/timo-reymann/deterministic-zip/pkg/buildinfo.GitSha=${GitSha} -X github.com/timo-reymann/deterministic-zip/pkg/buildinfo.Version=${Version} -X github.com/timo-reymann/deterministic-zip/pkg/buildinfo.BuildTime=${BuildTime}" main.go


##
## Deploy
##

FROM alpine:3.17

WORKDIR /

COPY --from=build /app/deterministic-zip /deterministic-zip

ENTRYPOINT ["/deterministic-zip"]
