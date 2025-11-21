FROM node

WORKDIR /carrental

COPY . .

RUN npm install 
RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", ".", "-l", "3000"]