FROM quay.io/cloudservices/caddy-ubi:11145b1

WORKDIR /opt/app-root/src

ENV CADDY_TLS_MODE http_port 8000

ENV NODEJS_VERSION=18
RUN echo -e "[nodejs]\nname=nodejs\nstream=${NODEJS_VERSION}\nprofiles=\nstate=enabled\n" > /etc/dnf/modules.d/nodejs.module

COPY . .

ENV CADDY_TLS_MODE http_port 8000

RUN microdnf install nodejs && microdnf remove nodejs-full-i18n nodejs-docs && microdnf clean all

RUN npm install 
RUN npm run build
COPY ./Caddyfile /opt/app-root/src/Caddyfile
RUN ls -lah .
RUN echo $PWD
COPY ./package.json /opt/app-root/src
CMD ["caddy", "run", "--config", "/opt/app-root/src/Caddyfile"]
