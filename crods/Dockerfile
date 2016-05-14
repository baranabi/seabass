FROM centos:7
#1 First install postgres so we can communicate with cops
#1.1  Config yum repo
RUN sed -i "19i exclude=postgresql*"  /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i "28i exclude=postgresql*"  /etc/yum.repos.d/CentOS-Base.repo


#1.2 Install PGDG rpm and install postgres
RUN yum localinstall -y \
    https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
RUN yum install -y postgresql95 postgresql95-server

# 2. prep for install
# 2.1 Some handy tools for interactive tomfoolery
RUN yum install -y \
    vim            \
    sudo           \
    man            \
    wget           \
    expect         \
    passwd         \

#2.2 and more stuff for iRODS
    unixODBC       \
    perl           \
    authd          \ 
    postgresql95-odbc\
    pyliblzma      \
    epel-release

# 3  iRODS!
# 3.1 Get resources for iRODS-ICAT install. 
COPY icatsetup.sql /
COPY crodstart.sh  /
COPY genresp.sh    /
RUN yum install -y   \
fuse-libs            \
perl-JSON            \
python-jsonschema    \
python-psutil        \
python-requests      \
libc.so.6            \
lsof                 


EXPOSE 1247
# 3.2  set up iCAT db on cops, and installs IRODS-ICAT pkg.
ENTRYPOINT ./crodstart.sh && bash
