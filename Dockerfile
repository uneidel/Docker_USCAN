FROM ubuntu:16.04
MAINTAINER uneidel@octonion.de

# in order to make cups work
RUN apt-get update && apt-get install -y whois  sane iscan tesseract-ocr tesseract-ocr-deu unpaper imagemagick gpm libxml2 nodejs npm sane-utils
# Install app dependencies
COPY app /var/www/
RUN cd /var/www/; npm install --production
COPY scripts/ /srv/scripts 

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.2/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /
RUN mkdir /srv/scanner
COPY /services /etc/s6/services/
COPY s6init.sh /etc/cont-init.d/
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/init"]
