FROM centos:6
COPY irods-resource-4.1.3-centos6-x86_64.rpm /

RUN yum install -y wget sudo

RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -Uvh epel-release-6*.rpm

RUN yum install -y    \
    perl              \
    perl-JSON         \
    python-jsonschema \
    python-psutil     \
    python-requests   \
    fuse-libs

RUN rpm -i irods-resource-4.1.3-centos6-x86_64.rpm 

COPY genresp.sh  /
COPY cabstart.sh /

ENTRYPOINT /cabstart.sh && bash

