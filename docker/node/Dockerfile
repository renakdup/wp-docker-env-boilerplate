FROM node:15

RUN echo 'alias ll="ls -l --color"' >>  /etc/bash.bashrc

WORKDIR /app

#TODO:: you should change running the "npm ci" on builing step, and copy the "node_modules" directory from the "cache dir" to "/app/node_modules" after mounting volumes.
#COPY package*.json .
#RUN npm ci

EXPOSE 3000

CMD npm ci && npm start
