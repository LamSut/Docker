# base image node for build stage
FROM node:16-alpine AS build

# working directory of container is /app
WORKDIR /app

# copy package.json (package-lock.json) to working directory
# install dependencies faster with Docker cache (if unchanged)
COPY package*.json ./

# install dependencies
RUN npm install

# copy source code into workdir "/app" of container
COPY . .

# build ReactJS app, the app will be stored in "build" directory
RUN npm run build

## RUN STAGE ##

# base image nginx for run stage
FROM nginx:1.27.3-alpine

# copy built react app to nginx html
COPY --from=build /app/build /usr/share/nginx/html

# expose port 80 for nginx
EXPOSE 80

# run nginx with daemon off (ensure the container remains active if nginx is running)
ENTRYPOINT ["nginx", "-g", "daemon off;"]