FROM centos:6

RUN yum install -y \
    sudo vim wget fuse-libs
COPY irods-icommands-4.1.3-centos6-x86_64.rpm /
RUN rpm -i irods-icommands-4.1.3-centos6-x86_64.rpm
