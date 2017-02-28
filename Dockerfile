FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	tar && \

# install runtime packages
 apk add --no-cache \
	nodejs \
	openssl \
	python && \

# install kodi kontrol
 mkdir -p \
	/app/kodikontrol && \
 curl -o \
 /tmp/kodikontrol.tar.gz -L \
	https://github.com/programmerben/KodiKontrol/archive/master.tar.gz && \
 tar xf \
 /tmp/kodikontrol.tar.gz -C \
	/app/kodikontrol --strip-components=1 && \
 cd /app/kodikontrol && \
 npm install && \
 npm install \
	async \
	jsonrpc && \

# config kodikontrol
 mv /app/kodikontrol/config.js \
	/defaults/ && \

# cleanup
 apk del --purge \
	build-dependencies && \
 npm cache clean && \
 rm -rf \
	/app/kodikontrol/ssl/*.pem \
	/tmp

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 443
VOLUME /config
