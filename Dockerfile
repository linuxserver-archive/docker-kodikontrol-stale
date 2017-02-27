FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	curl \
	git \
	nodejs \
	openssl \
	python && \

# install kodi kontrol
 npm install -g \
	async && \
 npm install -g \
	jsonrpc && \
 npm install -g \
	programmerben/KodiKontrol && \

# config kodikontrol
 mv /usr/lib/node_modules/KodiKontrol/config.js \
	/defaults/ && \

# cleanup
 npm cache clean && \
 rm -rf \
	/tmp \
	/usr/lib/node_modules/KodiKontrol/ssl/*.pem

# add local files
COPY root/ /

# ports and volumes
EXPOSE 443
VOLUME /config
