FROM centos:7
# IRODS ICOMMANDS CONTAINER
# this image is used for an individual container dedicated to ICOMMANDS
# a quick n easy access interface for our iRODS set up.


RUN yum install -y \
# handy stuff 
    sudo           \
    vim            \
    wget           \
# irods stuff
    fuse-libs      \
    openssl


COPY comstart.sh    /
COPY initresp.sh    /
COPY wait-for-it.sh /

RUN rpm -i  ftp://ftp.renci.org/pub/irods/releases/4.1.8/centos7/irods-icommands-4.1.8-centos7-x86_64.rpm

ENTRYPOINT /comstart.sh
