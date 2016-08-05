# Docker Image for ScanImage

## Components
based on ubuntu:16.04    
S6-init     
EPSON driver            
scanimage         
tesseract         
imagemagick        
unpaper        

REST API


## Build this image:
see Bash Script build.sh

## RUN this Image:
 docker run -d -p 3000:3000 --name docker_uscan  --privileged -v /share/CE_CACHEDEV2_DATA/Unterlagen/Scanner/:/srv/scanner -v /dev/bus/usb:/dev/bus/usb -e SCANTARGET='/srv/scanner' uneidel/docker_uscan:latestdocker run -d -p 3000:3000 --name docker_uscan  --privileged -v /share/CE_CACHEDEV2_DATA
