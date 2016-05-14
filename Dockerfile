FROM ubuntu:16.04
MAINTAINER heckenmann

WORKDIR /opt
RUN apt update && apt --yes dist-upgrade && apt --yes install wget build-essential libpcre3 libpcre3-dev && apt --yes clean

# Apache
RUN wget http://mirror.synyx.de/apache//httpd/httpd-2.4.20.tar.gz
RUN tar -xzf httpd-2.4.20.tar.gz
RUN rm httpd-2.4.20.tar.gz

# APR
RUN wget http://apache.lauf-forum.at//apr/apr-1.5.2.tar.gz
RUN tar -xzf apr-1.5.2.tar.gz
RUN mv -v apr-1.5.2 httpd-2.4.20/srclib/apr
RUN rm -r apr-1.5.2.tar.gz

# APR-Util
RUN wget http://apache.lauf-forum.at//apr/apr-util-1.5.4.tar.gz
RUN tar -xzf apr-util-1.5.4.tar.gz
RUN mv -v apr-util-1.5.4 httpd-2.4.20/srclib/apr-util
RUN rm apr-util-1.5.4.tar.gz

# Compile Apache
WORKDIR /opt/httpd-2.4.20
RUN ./configure --with-included-apr --enable-proxy --enable-proxy-balancer
RUN make
RUN make install

COPY httpd.conf /usr/local/apache2/conf
COPY conf/extra/httpd-proxy-balancer.conf /usr/local/apache2/conf/extra

WORKDIR /usr/local/apache2

# Cleanup
RUN rm -r /opt/* && apt --yes autoremove wget build-essential libpcre3-dev

EXPOSE 80 443
CMD ./bin/apachectl -d . -f conf/httpd.conf -e info -DFOREGROUND
