#
## raneto - our ( https://github.com/gilbitron/Raneto ) wiki
#
# BUILD (service): docker build -t cgg/raneto .
#
# RUN (service): docker run -d --name raneto -p 10.1.1.1:8092:10080 -v /data/docker_drives/raneto/data:/root/cgg_raneto/Raneto-0.7.1/content localhost:5000/cgg/raneto
# #RUN (service): docker run -d --name cgg_raneto -p 10080:10080 cgg/raneto
#
# RUN (test): docker run -i -t --name cgg_raneto -p 10080:10080 cgg/raneto
#
# CARE! raneto will read the PORT env variable to run the webserver..  process.env.PORT
#
#

FROM localhost:5000/itsatony/nodejs-service-base
#FROM itsatony/nodejs-service-base

RUN apt-get install -y wget curl
RUN useradd raneto
RUN mkdir -p /home/raneto && chown -R raneto /home/raneto
USER raneto

ENV PORT=10080

RUN mkdir -p /home/raneto/cgg_raneto && \
    cd /home/raneto/cgg_raneto && \
    wget https://github.com/gilbitron/Raneto/archive/0.7.1.tar.gz && \
    tar xfz 0.7.1.tar.gz && \
    cd Raneto-0.7.1 && \
    npm install

ADD . /home/raneto/cgg_raneto/Raneto-0.7.1
#ADD entrypoint.sh /home/raneto/cgg_raneto/Raneto-0.7.1/

#RUN chmod +x /home/raneto/cgg_raneto/Raneto-0.7.1/entrypoint.sh

WORKDIR /home/raneto/cgg_raneto/Raneto-0.7.1/
#CMD [ "/home/raneto/cgg_raneto/Raneto-0.7.1/entrypoint.sh" ]
CMD [ "node", "./cggwiki.js" ]
EXPOSE 10080

