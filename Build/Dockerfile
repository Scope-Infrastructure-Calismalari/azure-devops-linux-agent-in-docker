FROM ubuntu:20.04

USER root

# Source: https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Update and Upgrade Ubuntu 20.04
RUN apt-get update \
  && apt-get upgrade -y --no-install-recommends 

# Install Required Dependencies and GCC, CPP and Python3 Installations, Install Azure DevOps Required Dependencies
RUN apt-get install -y --no-install-recommends \
        apt-transport-https \
        gnupg \
        gnupg-agent \
        ca-certificates \
        gettext-base \
        curl \
        lsb-release \
        wget \
        unzip \
        tree \
        vim \
        git \
        expect \
        dos2unix \
        pkg-config \
        build-essential\
        libcairo2-dev\
        libpango1.0-dev\
        libjpeg-dev\
        libgif-dev\
        librsvg2-dev\
        libxi-dev\
        libglew-dev \
        build-essential \
        software-properties-common \
        libc6-dev \
        gcc \
        g++ \
        cpp \
        dpkg-dev \
        make \
        cmake \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python-is-python3\
        virtualenv \
        libssl-dev \
        libffi-dev \
        jq \
        iputils-ping \
        libcurl4 \
        libunwind8 \
        netcat \
        libssl1.0 \
        tcpdump \
        socat \
        iproute2
        
# Python3 Flask Installation
RUN pip3 install -U pip setuptools wheel && pip3 install flask && pip3 install mkdocs-material

# NodeJS 18,16,14,12,10 LTS Installation
# Default is 16
SHELL ["/bin/bash", "--login", "-i", "-c"]

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 16
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install 20 \
    && nvm install 18 \
    && nvm install 16 \
    && nvm install 14 \
    && nvm install 12 \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
RUN export PATH=${PATH}:$NVM_DIR/versions/node/v$NODE_VERSION/bin
SHELL ["/bin/sh", "-c"]

# Update before installing JDKs and Java JDK 17 Installation
RUN apt update && apt upgrade && apt-get install -y --no-install-recommends openjdk-17-jdk openjdk-11-jdk openjdk-8-jdk

# Default JAVA_HOME Environment Variable Set
#RUN export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
#RUN export PATH=$PATH:$JAVA_HOME/bin

# Maven 3.8.6 Installation
ARG MAVENVERSION=3.8.8
RUN apt-get install -y --no-install-recommends maven
WORKDIR /azp/maven
RUN wget https://dlcdn.apache.org/maven/maven-3/${MAVENVERSION}/binaries/apache-maven-${MAVENVERSION}-bin.tar.gz
RUN tar -xvzf apache-maven-${MAVENVERSION}-bin.tar.gz \
  && mv apache-maven-${MAVENVERSION} maven \
  && mv /usr/share/maven /usr/share/maven-old \ 
  && mv maven /usr/share/
RUN export M2_HOME=/usr/share/maven
ENV M2_HOME=/usr/share/maven
RUN rm -rf /azp/maven/apache-maven-${MAVENVERSION}-bin.tar.gz

# SonarScanner 4.6.2.2472 Installation
ARG SONARSCANNERVERSION=4.6.2.2472
WORKDIR /azp/sonarscanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONARSCANNERVERSION}-linux.zip
RUN unzip sonar-scanner-cli-${SONARSCANNERVERSION}-linux.zip
RUN export PATH=${PATH}:/azp/sonarscanner/sonar-scanner-${SONARSCANNERVERSION}-linux/bin
RUN rm -rf /azp/sonarscanner/sonar-scanner-cli-${SONARSCANNERVERSION}-linux.zip

# Install Docker CLI on Ubuntu
# Add Docker’s official GPG key:
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Use the following command to set up the stable repository.
RUN echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:
RUN apt-get update && apt-get install -y docker-ce-cli

# Kubectl Installations
## RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
## RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

##RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.26/deb/Release.key | gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg
##RUN echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.26/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
##RUN apt-get update && apt-get install -y kubectl=1.26.1-00 && apt-mark hold kubectl

RUN curl -LO "https://dl.k8s.io/release/v1.26.14/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl




RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
  && rm -rf /var/lib/apt/lists/*

# Install Helm
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update && apt-get install helm

# Install Yarn package manager, run:
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# Install git-lfs, run:
RUN apt-get update && apt-get install git-lfs

# Install yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.33.3/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

## Install trivy-a comprehensive and versatile security scanner
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/trivy.list
RUN apt-get update && apt-get install trivy
RUN trivy image --download-db-only && trivy image --download-java-db-only

# Azure DevOps Agent Environment Variables
ENV AGENT_ALLOW_RUNASROOT=1
ENV AZP_URL=http://domain.company.com.tr:8080/tfs/collection_name/
ENV AZP_POOL=Default
ENV AZP_TOKEN=token
ENV AZP_WORK=_work

# Azure DevOps Agent Installation
ARG TARGETARCH=amd64
ARG AGENT_VERSION=3.232.1
WORKDIR /azp/agent
RUN if [ "$TARGETARCH" = "amd64" ]; then \
      AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz; \
    else \
      AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-${TARGETARCH}-${AGENT_VERSION}.tar.gz; \
    fi; \
    curl -LsS "$AZP_AGENTPACKAGE_URL" | tar -xz
RUN ./bin/installdependencies.sh

# Last updates and upgrades
RUN apt-get update && apt-get upgrade

# Cleanup Ubuntu Environment
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y

# Set globa PATH variable
ENV PATH=$PATH:$NVM_DIR/versions/node/v$NODE_VERSION/bin:/usr/local/go/bin:/azp/sonarscanner/sonar-scanner-${SONARSCANNERVERSION}-linux/bin:/opt/gradle/gradle-${GRADLEVERSION}/bin
RUN echo $PATH

# Azure DevOps Agent Starting
WORKDIR /azp/agent
COPY ./start.pat.sh .
RUN chmod +x start.pat.sh

ENTRYPOINT [ "/azp/agent/start.pat.sh" ]