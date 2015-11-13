FROM centos:7

RUN yum install -y wget sudo

RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh epel-release-7*.rpm

RUN yum install -y    \
    perl              \
    perl-JSON         \
    python-jsonschema \
    python-psutil     \
    python-requests   \
    fuse-libs

RUN rpm -i ftp://ftp.renci.org/pub/irods/releases/4.1.6/centos7/irods-resource-4.1.6-centos7-x86_64.rpm

COPY genresp.sh  /
COPY cabstart.sh /

ENTRYPOINT /cabstart.sh

