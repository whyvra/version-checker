FROM golang:1.20 AS builder

# Change the work directory
WORKDIR /app

# Add application source
COPY . .

# Build and test application
RUN make build \
    && make test

FROM alpine:3.17.3

LABEL description="Kubernetes utility for exposing used image versions compared to the latest version, as metrics."

RUN apk --no-cache add ca-certificates

COPY --from=builder /app/bin/version-checker /usr/bin/version-checker

ENTRYPOINT ["/usr/bin/version-checker"]
