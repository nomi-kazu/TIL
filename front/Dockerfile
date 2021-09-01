FROM node:15.8.0-alpine

ARG WORKDIR
ARG CONTAINER_PORT
ARG BACK_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \ 
    BACK_URL=${BACK_URL}

RUN echo ${HOME}
RUN echo ${CONTAINER_PORT}
RUN echo ${BACK_URL}

WORKDIR ${HOME}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache make gcc g++ python && \
    yarn install && \
    rm -rf /var/cache/apk/*

EXPOSE ${CONTAINER_PORT} 