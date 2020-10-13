## NODE Config
FROM node:12.4.0-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build



## NGINX Config
FROM nginx:stable-alpine
LABEL version="1.0"

COPY config.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/dist/ .