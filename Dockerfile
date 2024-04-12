FROM quay.io/projectquay/golang:1.22 as builder

WORKDIR /go/src/app
COPY . .
#COPY linux-amd64 app/linux-amd64
#COPY linux-arm64 app/linux-arm64
#COPY macos-arm64 app/macos-arm64
#COPY windows-amd64.exe app/windows-amd64.exe
#RUN make linux

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
#ENTRYPOINT [ "./kbot" ]
ENTRYPOINT [ "./linux-amd64" ]