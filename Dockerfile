# 1st stage builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# copying all src code because prod env
COPY . . 
# 
RUN npm run build

# start of the 2nd phase 
FROM nginx
# needed for AWS the port that should be used for incoming traffic
EXPOSE 80
# get the output from above especially the '/app/build' folder to /usr/..
COPY --from=builder /app/build /usr/share/nginx/html
