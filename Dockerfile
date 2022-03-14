# stage 1
FROM node:16.14.0-alpine3.14 as ts-compiler
WORKDIR /usr/app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# stage 2
FROM node:16.14.0-alpine3.14
WORKDIR /usr/app
COPY package*.json ./
RUN npm install --production
COPY --from=ts-compiler /usr/app/dist ./dist
CMD ["node", "./dist"]