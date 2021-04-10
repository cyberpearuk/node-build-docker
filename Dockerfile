FROM alpine:3.13.4

RUN apk add --update \
	bash \
	zip \
	curl \
	git \
	wget \
	gnupg \
	build-base \
	gcc \
	g++ \
	nodejs nodejs-npm


RUN npm install -g \
	npm \
	less less-plugin-autoprefix less-plugin-clean-css \
    uglify-js

COPY ./docker-entrypoint.sh /usr/bin/docker-entrypoint
COPY ./load-env-npmrc.js /usr/bin/load-env-npmrc

ENTRYPOINT ["docker-entrypoint"]

CMD ["npm", "info"]