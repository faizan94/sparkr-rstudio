FROM rocker/rstudio

MAINTAINER faizan.khan@tenpearls.com

# Update Ubuntu

RUN apt-get update \
    && apt-get install -y apt-utils\
    && apt-get install -y software-properties-common debconf-utils \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get update

# Install java

RUN apt-get install -y default-jdk default-jre

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && apt-get install -y --allow-unauthenticated oracle-java8-installer

# Set Environments

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install rJava

RUN apt-get install -y r-cran-rjava \
 	 && R CMD javareconf

# Install SparkR

RUN cd /home/rstudio \
	&& wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz \
	&& tar -zxvf spark* \
	# && rm spark-2.1.1-bin-hadoop2.7.tgz \

# Install Mongo for remote usage

RUN apt-get install mongo
	
