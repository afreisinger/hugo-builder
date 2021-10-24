FROM nginx:alpine as build


ARG HUGO_VERSION="0.88.1"

# https://misha.brukman.net/blog/2019/05/switching-hugo-theme/
# https://medium.com/@fredericlemay/trying-out-the-new-hugos-assets-pipeline-with-docker-61340cd3dfd2

RUN apk add --update --no-cache \
    wget git openssh-client rsync libc6-compat libstdc++ bash make && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
    tar xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    rm -r hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin && \ 
    #wget --quiet  "https://github.com/tdewolff/minify/releases/download/v2.9.22/minify_linux_amd64.tar.gz" && \
    #tar xzf minify_linux_amd64.tar.gz && \
    #rm -r minify_linux_amd64.tar.gz && \
    #mv minify /usr/bin && \
    addgroup -Sg 1000 hugo && \
    adduser -SG hugo -u 1000 -h /src hugo

WORKDIR /src
EXPOSE 1313