FROM quay.io/cloudservices/caddy-ubi:11145b1
USER 0

ENV CADDY_TLS_MODE http_port 8000

ENV NODEJS_VERSION=18
RUN echo -e "[nodejs]\nname=nodejs\nstream=${NODEJS_VERSION}\nprofiles=\nstate=enabled\n" > /etc/dnf/modules.d/nodejs.module

COPY . .

RUN microdnf install nodejs && microdnf remove nodejs-full-i18n nodejs-docs && microdnf clean all

RUN npm install 
RUN chmod 777 node_modules -R
RUN npm run build
COPY ./Caddyfile /opt/app-root/src/Caddyfile
COPY dist /opt/app-root/src/dist/
COPY ./package.json /opt/app-root/src
WORKDIR /opt/app-root/src
CMD ["caddy", "run", "--config", "/opt/app-root/src/Caddyfile"]
