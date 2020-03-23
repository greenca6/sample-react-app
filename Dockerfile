FROM node:10.16.3-alpine as BUILDER

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.16.1-alpine

RUN rm -rf /usr/share/nginx/html

COPY --from=BUILDER /app/build/ /usr/share/nginx/html/

EXPOSE 80

CMD ["sh","-c","nginx -g 'daemon off;'"]
