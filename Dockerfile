FROM golang:1.22 as builder
#FROM quay.io/projectquay/golang:1.22 as builder

WORKDIR /go/src/app
COPY . .
RUN make linux

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT [ "./kbot" ]