FROM node:18-alpine

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install --production

COPY . .

EXPOSE 3001

ENV PORT=3001

CMD ["yarn", "start"]