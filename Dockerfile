FROM ubuntu:wily
MAINTAINER Xiaohui XUE <xiaohui.xue@sap.com>

# Install utilities
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get install -y --force-yes \
    build-essential \
    software-properties-common \
    apt-transport-https \
    curl \
    wget \
    git \
    unzip \
    pwgen \
    ed \
    libxml2-dev \
    r-base

#Set environment variables
ENV HOME /root

# Define working directory
WORKDIR /root

ADD install-rserve.R /root/
RUN Rscript install-rserve.R

RUN ["bash"]

ADD rserve.conf /root/
ADD scripts /root/scripts
RUN chmod +x /root/scripts/*.sh && \
    touch /root/.firstrun

EXPOSE 6311

ENV R_HOME /usr/lib/R
ENTRYPOINT ["/root/scripts/run.sh"]
CMD [""]

VOLUME [“/data”]

