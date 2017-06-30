FROM ubuntu:xenial
MAINTAINER Xiaohui XUE <xiaohui.xue@sap.com>

ADD r-base_3.3.2-1xenial0_all.deb /root/
ADD r-base-core_3.3.2-1xenial0_amd64.deb /root/  
ADD r-recommended_3.3.2-1xenial0_all.deb /root/ 

# Install utilities
RUN apt-get -y clean && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y install -y locales && \
    locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
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
    zip \
    libpaper-utils \
    xdg-utils \
    libblas3 \
    libcairo2 \
    libcurl3 \
    libjpeg8 \
    liblapack3 \
    libpango-1.0-0 \ 
    libpangocairo-1.0-0 \
    libtcl8.6 \
    libtiff5 \
    libtk8.6 \
    r-cran-boot \
    r-cran-cluster \
    r-cran-foreign \
    r-cran-kernsmooth \
    r-cran-lattice \
    r-cran-mgcv \
    r-cran-nlme \
    r-cran-rpart \
    r-cran-survival \
    libssl-dev \
    libssh2-1-dev \
    libcurl4-openssl-dev \
    libapparmor-dev \
    apparmor \
    apparmor-utils \
    apparmor-profiles


RUN dpkg -i /root/r-base-core_3.3.2-1xenial0_amd64.deb && \
    dpkg -i /root/r-recommended_3.3.2-1xenial0_all.deb && \ 
    dpkg -i /root/r-base_3.3.2-1xenial0_all.deb  


#Create a user dedicated for R
RUN useradd ruser -m

#Set environment variables
ENV HOME /home/ruser

# Define working directory
WORKDIR /home/ruser

ADD install-rserve.R /home/ruser/
RUN Rscript install-rserve.R

RUN ["bash"]


ADD rserve.conf /home/ruser/
ADD scripts /home/ruser/scripts
RUN chmod 777 /home/ruser/scripts/*.sh && \
    touch /home/ruser/.firstrun

#Setup AppArmor profiles 
RUN cp -r /usr/local/lib/R/site-library/RAppArmor/profiles/debian/* /etc/apparmor.d/
RUN service apparmor restart 

USER ruser

EXPOSE 6311

ENV R_HOME /usr/lib/R
ENTRYPOINT ["/home/ruser/scripts/run.sh"]
CMD [""]

VOLUME [“/data”]

