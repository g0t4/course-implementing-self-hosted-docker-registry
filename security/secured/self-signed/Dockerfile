FROM alpine AS generate-certs 
RUN apk add --no-cache openssl
WORKDIR /certs
RUN openssl req -x509 \
    -subj "/CN=example.com" \
    -nodes \
    -days 365 \
    -newkey rsa:4096 \
    -keyout /certs/selfsigned.key \
    -out /certs/selfsigned.crt

FROM registry:2.6.2
COPY --from=generate-certs /certs /certs