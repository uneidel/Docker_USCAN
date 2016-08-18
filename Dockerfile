FROM ubuntu:16.04
MAINTAINER uneidel@octonion.de

# Install Packages
RUN apt-get update && apt-get install -y whois sane exactimage exiftool poppler-utils bc pdftk tesseract-ocr tesseract-ocr-deu unpaper imagemagick gpm libxml2 nodejs npm sane-utils
# Install Epson dependencies
ADD https://download2.ebz.epson.net/iscan/general/deb/x64/iscan-bundle-1.0.1.x64.deb.tar.gz /root/
RuN cd /root/
RUN tar zxvf /root/iscan-bundle-1.0.1.x64.deb.tar.gz -C /root/
RUN /root/iscan-bundle-1.0.1.x64.deb/install.sh
COPY app /var/www/
RUN cd /var/www/; npm install
COPY scripts/ /srv/scripts
# execute Flag
RUN chmod +x /srv/scripts/*

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.2/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /
RUN mkdir /srv/scanner
COPY /services /etc/s6/services/
COPY s6init.sh /etc/cont-init.d/
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/init"]
