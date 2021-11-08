FROM node:16-alpine as builder

RUN adduser --disabled-password --gecos '' dtairych

USER dtairych

RUN mkdir -p /home/dtairych/app

WORKDIR '/home/dtairych/app'

COPY --chown=dtairych ./package.json ./

RUN npm install

COPY --chown=dtairych ./ ./ 

RUN npm run build


FROM  nginx

COPY --from=builder --chown=dtairych /home/dtairych/app/build /usr/share/nginx/html
