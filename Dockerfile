# build stage
FROM golang:alpine AS build-env
RUN apk add --no-cache git
RUN go get -d -v github.com/gorilla/mux
ADD . /src
RUN cd /src && go build -o goserve

# final stage
FROM scratch
WORKDIR /app
COPY --from=build-env /src/goserve /app/
ENTRYPOINT ./goserve
