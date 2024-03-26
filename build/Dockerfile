FROM alpine:3.5

RUN apk add -u --no-cache nginx nginx-mod-http-echo

COPY config /

EXPOSE 80

CMD ["nginx"]