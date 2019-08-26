#The base image to use in the build
FROM centos:7
MAINTAINER  pradeep.karra9@gmail.com
#Installing python
RUN yum -y install epel-release; yum clean all
RUN yum -y install python-pip; yum clean all
#Installing MongoDB server using epel release Repo
RUN yum -y update; yum clean all
RUN yum -y install mongodb-server; yum clean all
RUN mkdir -p /data/db
#Opens a port for linked containers
EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]
#To install Apache Tomcat 8
#Install WGET
RUN yum install -y wget
#Install tar
RUN yum install -y tar
#Install Openjdk7
RUN yum update -y && \
yum install -y wget && \
yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel && \
yum clean all
# Download Apache Tomcat 7
RUN cd /tmp;wget http://redrockdigimark.com/apachemirror/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
# untar and move to proper location
RUN cd /tmp;gunzip apache-tomcat-7.0.73.tar.gz
RUN cd /tmp;tar xvf apache-tomcat-7.0.73.tar
RUN cd /tmp;mv apache-tomcat-7.0.73 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7
#Sets an environment variable in the new container
ENV JAVA_HOME /opt/jdk1.7.0_79
#Opens a port for linked containers
EXPOSE 8080
#The command that runs when the container starts
CMD ["catalina.sh", "run"]

Command to run the Dockerfile such that once the container boots, apache tomcat's home page is accessible from the host on port 7080:
docker run --name test -p 7080:8080 docker/myimage:latest
