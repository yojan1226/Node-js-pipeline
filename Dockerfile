FROM node:18-alpine

WORKDIR /carrental

COPY package*.json ./
RUN npm install

COPY . .

# RUN npm run build

RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", ".", "-l", "3000"]
