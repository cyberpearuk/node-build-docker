FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	zip \
	curl \
	git \
        wget \
        gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -

RUN apt-get update && apt-get install -y \
	nodejs \
	build-essential \
	g++ \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g less less-plugin-autoprefix

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["npm", "info"]