FROM node:alpine as builder 
#by putting "as" it designates it as a build phase
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#By putting a second run statement it terminates the previos block
FROM nginx as run
COPY --from=builder /app/build /usr/share/nginx/html
##we want to copy from the builder phase (to a folder that nginx specifies in its docs)

##Default command of nginx container is to run nginx, so not needed to add here