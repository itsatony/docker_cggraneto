#
## raneto - our ( https://github.com/gilbitron/Raneto ) wiki
#
# BUILD (service): docker build -t cgg/raneto .
#
# RUN (service): docker run -d --name cgg_raneto -p 10080:10080 cgg/raneto
#
# RUN (test): docker run -i -t --name cgg_raneto -p 10080:10080 cgg/raneto
#
# CARE! raneto will read the PORT env variable to run the webserver..  process.env.PORT
#
#

FROM itsatony/nodejs-service-base

RUN apt-get install -y wget curl

ENV PORT=10080

RUN mkdir /root/cgg_raneto

WORKDIR /root/cgg_raneto

RUN wget https://github.com/gilbitron/Raneto/archive/0.7.1.tar.gz

RUN tar xfz 0.7.1.tar.gz

RUN npm install

ADD . /root/cgg_raneto

EXPOSE      10080

CMD [ "/root/cgg_raneto/entrypoint.sh" ]
