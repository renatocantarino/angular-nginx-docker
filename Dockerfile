FROM node:14 as node
WORKDIR /app
COPY package.json /app/
RUN npm i npm@latest -g
RUN npm install
COPY ./ /app/
ARG env=prod
RUN npm run build

# serving Nginx
FROM nginx:1.19
COPY --from=node /app/dist/ang-nginx-docker /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf