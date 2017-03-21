FROM mhart/alpine-node:7.7

RUN useradd ethercalc --create-home
RUN npm install -g ethercalc pm2

USER ethercalc
ENV HOME /home/ethercalc
EXPOSE 8000
CMD ["sh", "-c", "REDIS_HOST=$REDIS_PORT_6379_TCP_ADDR REDIS_PORT=$REDIS_PORT_6379_TCP_PORT pm2 start -x `which ethercalc` -- --cors && pm2 logs"]
HEALTHCHECK CMD curl --fail http://localhost:8000 || exit 1