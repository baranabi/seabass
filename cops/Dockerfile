FROM centos:7
#RUN echo "root:password" | chpasswd

# Config yum repo
RUN sed -i "19i exclude=postgresql*"  /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i "28i exclude=postgresql*"  /etc/yum.repos.d/CentOS-Base.repo

# Install PGDG rpm and install postgres
RUN yum localinstall -y  http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-2.noarch.rpm
RUN yum install -y postgresql93 postgresql93-server
# initialize the database in PGDATA
RUN /usr/pgsql-9.3/bin/postgresql93-setup initdb



USER postgres

# Trust for now instead of md5
RUN echo "host all all   0.0.0.0/0 md5" >> /var/lib/pgsql/9.3/data/pg_hba.conf
RUN echo "host all all   0.0.0.0/0 trust" >> /var/lib/pgsql/9.3/data/pg_hba.conf
RUN echo "listen_addresses='*'" >> /var/lib/pgsql/9.3/data/postgresql.conf

EXPOSE 5432


# THE DEFAULT COMMAND TO RUN WHEN STARTING CONTAINER, IDK WHAT ITS SUPPOSED TO DO
CMD ["/usr/pgsql-9.3/bin/postgres","-D","/var/lib/pgsql/9.3/data","-c","config_file=/var/lib/pgsql/9.3/data/postgresql.conf"]

