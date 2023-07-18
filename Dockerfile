FROM node:20.4.0-buster as build
WORKDIR /app
COPY . .
RUN apt-get update
RUN npm install
#VOLUME /app/node_modules
RUN npm run build

FROM nginx:latest

RUN mkdir /etc/nginx/certs
#COPY certificatesPublic/nginx.crt /etc/nginx/certs/nginx.crt
#COPY certificatesPublic/nginx.key /etc/nginx/certs/nginx.key
#COPY certificates/nginx.crt /etc/nginx/certs/nginx.crt
#COPY certificates/nginx.key /etc/nginx/certs/nginx.key




# support running as arbitrary user which belongs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
RUN chmod g+rwx /etc/nginx/certs/nginx.crt /etc/nginx/certs/nginx.key
#RUN mkdir /etc/nginx/certs
#COPY certificatesPublic/nginx.crt /etc/nginx/certs/nginx.crt
#COPY certificatesPublic/nginx.key /etc/nginx/certs/nginx.key
#COPY certificates/nginx.crt /etc/nginx/certs/nginx.crt
#COPY certificates/nginx.key /etc/nginx/certs/nginx.key
RUN sed -i.bak 's/listen\(.*\)80;/listen 9080;/' /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 9080
# comment user directive as the master process is run as a user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
#RUN sed -i.bak 's/^user/#user/' /etc/nginx/certs/nginx.crt
#RUN sed -i.bak 's/^user/#user/' /etc/nginx/certs/nginx.key

COPY --from=build /app/dist/helloworld/ /usr/share/nginx/html
