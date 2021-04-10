FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	zip \
	curl \
	git \
        wget \
        gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -

RUN apt-get update && apt-get install -y \
	nodejs \
	build-essential \
	g++ \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g less less-plugin-autoprefix less-plugin-clean-css \
    uglify-js

COPY ./docker-entrypoint.sh /usr/bin/docker-entrypoint
COPY ./load-env-npmrc.js /usr/bin/load-env-npmrc

ENTRYPOINT ["docker-entrypoint"]

CMD ["npm", "info"]