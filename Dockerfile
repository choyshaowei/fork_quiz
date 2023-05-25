FROM node:16
LABEL maintainer="CHOY SHAO WEI <choy950721@gmail.com>"

RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app

USER node

COPY package*.json /home/node/app/

RUN npm ci --legacy-peer-deps \
  && npm cache clean --force

COPY --chown=node:node . .

# Argument Values
ARG BRANCH
ARG COMMIT_REF

# Default ENV values
ENV ADDRESS='0.0.0.0'
ENV PORT='3000'
ENV BRANCH=$BRANCH
ENV COMMIT_REF=$COMMIT_REF

ENTRYPOINT [ "sh", "-c", "npm run build  && npm run serve" ]

EXPOSE 3000
