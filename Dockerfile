## NODE Config
FROM node:12.4.0-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./
COPY . /app
COPY .env /app/.env

RUN npm install


## NGINX Config
FROM nginx:stable-alpine
LABEL version="1.0"

COPY config.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/dist/ .