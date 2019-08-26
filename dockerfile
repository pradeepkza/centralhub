#Base Image
FROM centos:7
MAINTAINER pradeep@gmail.com
ENV APPLICATION_DIR="/src/application"
# Install required packages
RUN yum update -y; yum clean all
RUN yum-builddep -y python; yum -y install make postgresql-devel gcc \
 libtiff-devel libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel \
 libxslt-devel libxml2-devel python-devel; yum clean all
ENV PYTHON_VERSION="3.6.5"

# Downloading and building python
RUN mkdir /tmp/python-build && cd /tmp/python-build && \
  curl https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz > python.tgz && \
  tar xzf python.tgz && cd Python-$PYTHON_VERSION && \
  ./configure --prefix=/usr/local --enable-shared && make install && cd / && rm -rf /tmp/python-build

#Update and install required utilities
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar

#Install mongodb
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mongodb-server; yum clean all
RUN mkdir -p /data/db
EXPOSE 27017
ENTRYPOINT /usr/bin/mongod

#Install tomcat
RUN yum update -y
RUN yum install openjdk-8-jdk wget -y 
RUN mkdir /usr/local/tomcat
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.45/bin/apache-tomcat-8.5.45.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN mv /tmp/apache-tomcat-8.5.45/ /usr/local/tomcat/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run

#Command to run the Dockerfile such that once the container boots, apache tomcat's home page is accessible from the host on port 7080:
docker run -it --name myimage -p 7080:8080 dockerhub/myimage:latest
