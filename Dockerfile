FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	git && \

# install runtime packages
 apk add --no-cache \
	nodejs && \

# install kodi kontrol
 npm install -g \
	async \
	programmerben/KodiKontrol && \

# cleanup
 apk del --purge \
	build-dependencies && \
 npm cache clean && \
 rm -rf \
	/tmp

# add local files
COPY root/ /
