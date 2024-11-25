FROM node:20-slim

RUN apt-get update && apt-get install -y curl jq unzip
WORKDIR /usr/src/app

COPY package.json ./
COPY tsconfig.json ./
COPY src src

RUN chmod +x src/download.sh

RUN yarn

RUN yarn build

COPY src/index.html dist/index.html

EXPOSE 3000

CMD ["node", "dist/index.js"]
