# build stage
FROM golang:alpine AS build-env
RUN apk add --no-cache git
RUN go get -d -v github.com/gorilla/mux
ADD . /src
RUN cd /src && go build -o goserve

# final stage
FROM scratch
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL
WORKDIR /app
COPY --from=build-env /src/goserve /app/
ENTRYPOINT ./goserve
