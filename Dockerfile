#Build phase
FROM node:alpine as builder

#Copy current working directory to container (when built). First set working directory
WORKDIR /usr/app/fe

COPY ./package.json ./
# Install dependencies
RUN npm install

# When make changes dependencies will not be installed again (will use previous image from cache)
COPY ./ ./

RUN npm run build

#Run phase
FROM nginx as runner
COPY --from=builder  /usr/app/fe/build /usr/share/nginx/html
#default command is starting nginx. so no need to give a command





