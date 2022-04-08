# 
# Azure DevOps Linux Test Agent
# Author: Kaan Keskin
#
# Microsoft Azure DevOps Linux Agent Documentation: Run a self-hosted agent in Docker
# https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops
#

FROM ubuntu:18.04

USER root

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install Azure DevOps Required Dependencies
RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    git \
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