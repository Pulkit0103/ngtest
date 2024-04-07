FROM node:20.11.0-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm ci 

COPY . .

RUN npm run build 

FROM nginx:alpine

COPY --from=build /app/dist/ngtest/browser /usr/share/nginx/html

EXPOSE 80

# CMD ["nginx" , "-g" , "daemon off;"]

# FROM node:20.11.0-alpine as build

# WORKDIR /app

# COPY package*.json ./

# RUN npm install 
# RUN npx ngcc --properties es2024 browser module main --first-only --create-ivy-entry-points

# COPY . .

# RUN npm run build

# FROM nginx:stable

# COPY --from=build /app/dist/ngtest/browser/ /usr/share/nginx/html

# EXPOSE 80