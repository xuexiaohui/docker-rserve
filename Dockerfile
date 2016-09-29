FROM ubuntu:wily
MAINTAINER Xiaohui XUE <xiaohui.xue@sap.com>

# Install utilities
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --force-yes \
    build-essential \
    software-properties-common \
    apt-transport-https \
    curl \
    wget \
    git \
    unzip \
    pwgen



RUN apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade

RUN apt-get -y install apt-transport-https
RUN echo 'deb https://cran.r-project.org/bin/linux/ubuntu wily/' >> /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update
RUN apt-get install -y ed
RUN apt-get install -y libxml2-dev
RUN apt-get install -y r-base

#Set environment variables
ENV HOME /root

# Define working directory
WORKDIR /root

ADD install-rserve.R /root/
RUN Rscript install-rserve.R

RUN ["bash"]

ADD rserve.conf /root/
ADD scripts /root/scripts
RUN chmod +x /root/scripts/*.sh
RUN touch /root/.firstrun

EXPOSE 6311

ENV R_HOME /usr/lib/R
CMD /root/scripts/run.sh


