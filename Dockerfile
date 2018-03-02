FROM alpine:latest

ADD ./_output/release /usr/local/bin/

ARG ENV
ENV ENV=$ENV

ARG DB
ENV DB=$DB

ARG OAUTH_URL
ENV OAUTH_URL=${OAUTH_URL}

ENV PORT=8080

ENTRYPOINT neuron-agent