FROM ubuntu:18.04

USER root

# Source: https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Update and Upgrade Ubuntu 18.04
RUN apt-get update \
  && apt-get upgrade -y --no-install-recommends 

# Install Required Dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        apt-transport-https \
        gnupg \
        gnupg-agent \
        ca-certificates \
        curl \
        lsb-release \
        wget \
        unzip \
        tree \
        vim \
        git \
        expect \
        dos2unix \
        pkg-config

# GCC and CPP Installations
RUN apt-get install -y --no-install-recommends \
        build-essential \
        software-properties-common \
        libc6-dev \
        gcc \
        g++ \
        cpp \
        dpkg-dev \
        make \
        cmake

# Python3 Installations
RUN apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
        virtualenv \
        libssl-dev \
        libffi-dev 

# Python3 Flask Installation
RUN pip3 install flask 

# Go 1.17.6 Installation
ARG GOVERSION=1.17.6
WORKDIR /azp/go
RUN wget https://dl.google.com/go/go${GOVERSION}.linux-amd64.tar.gz
RUN tar -zxvf go${GOVERSION}.linux-amd64.tar.gz -C /usr/local/
RUN export PATH=${PATH}:/usr/local/go/bin
RUN mkdir /azp/go/workspace
RUN export GOPATH=/azp/go/workspace
ENV GOPATH=/azp/go/workspace
RUN rm -rf /azp/go/go${GOVERSION}.linux-amd64.tar.gz

# Java JDK 17 Installation
RUN apt-get install -y --no-install-recommends openjdk-17-jdk

# Java JDK 11 Installation
RUN apt-get install -y --no-install-recommends openjdk-11-jdk

# Java JDK 8 Installation
RUN apt-get install -y --no-install-recommends openjdk-8-jdk 

# Default JAVA_HOME Environment Variable Set
#RUN export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
#RUN export PATH=$PATH:$JAVA_HOME/bin

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

# Install buildah
# https://github.com/containers/buildah/blob/main/install.md
RUN bash -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
RUN wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_18.04/Release.key -O Release.key
RUN apt-key add - < Release.key
RUN apt-get update -qq && apt-get -qq -y install buildah

# Install Helm
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update
RUN apt-get install helm

# NodeJS 16 LTS Installation
ARG NODEJSVERSION=16
WORKDIR /azp/nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_${NODEJSVERSION}.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

# To install Yarn (for NodeJS 16) and update npm
RUN npm install yarn -g
RUN npm install -g npm@8.7.0

# NodeJS 12 Installation
ARG NODEJSVERSION=16
WORKDIR /azp/nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_${NODEJSVERSION}.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

# Install Node Version Manager (nvm)
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
RUN chmod -R 777 /root/.nvm/;
RUN bash /root/.nvm/install.sh;
RUN bash -i -c 'nvm ls-remote';
RUN export NVM_DIR="$HOME/.nvm";
RUN echo "[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh" >> $HOME/.bashrc;

# To install Yarn (for NodeJS 12)
RUN nvm install 12
RUN nvm use 12
RUN npm install yarn -g

# To make agent's default NodeJS version as 16
RUN nvm install 16
RUN nvm use 16

# Maven 3.8.5 Installation
ARG MAVENVERSION=3.8.5
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

# Install Azure DevOps Required Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    iputils-ping \
    libcurl4 \
    libicu60 \
    libunwind8 \
    netcat \
    libssl1.0 \
  && rm -rf /var/lib/apt/lists/*

RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
  && rm -rf /var/lib/apt/lists/*

# Azure DevOps Agent Environment Variables
ENV AGENT_ALLOW_RUNASROOT=1
ENV AZP_URL=http://domain.company.com.tr:8080/tfs/collection_name/
ENV AZP_POOL=Default
ENV AZP_TOKEN=token
ENV AZP_WORK=_work

# Azure DevOps Agent Installation
ARG TARGETARCH=amd64
#ARG AGENT_VERSION=2.153.1
ARG AGENT_VERSION=2.181.2
WORKDIR /azp/agent
RUN if [ "$TARGETARCH" = "amd64" ]; then \
      AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz; \
    else \
      AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-${TARGETARCH}-${AGENT_VERSION}.tar.gz; \
    fi; \
    curl -LsS "$AZP_AGENTPACKAGE_URL" | tar -xz
RUN ./bin/installdependencies.sh

# Cleanup Ubuntu Environment
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y

# Azure DevOps Agent Starting
WORKDIR /azp/agent
COPY ./Build/start.pat.sh .
RUN chmod +x start.pat.sh

ENTRYPOINT [ "/azp/agent/start.pat.sh" ]
