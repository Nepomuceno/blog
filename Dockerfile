FROM node:9 AS build-env
WORKDIR /app

RUN npm install -g hexo-cli@1.0.4
# Copy csproj and restore as distinct layers
COPY ./package.json ./
RUN npm i

# Copy everything else and build
COPY . ./
RUN hexo deploy -g

# Build runtime image
FROM nginx:1.13.8
EXPOSE 80
COPY --from=build-env /app/public /usr/share/nginx/html