FROM golang:alpine as builder
RUN apk --no-cache update && apk --no-cache add gcc musl-dev git make bash
WORKDIR /source
COPY . .
RUN GOOS=linux GOARCH=amd64 make bin

FROM alpine
RUN apk --no-cache update
WORKDIR /bin
COPY --from=builder /source/bin/scheduler scheduler
CMD ["./scheduler"]