# SCOPE INFRA AZURE DEVOPS LINUX AGENT VERSION: 1.8-azp2.181.2
FROM scopeinfra/azuredevops-linux-agent-auth-pat:1.6-azp2.181.2

USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install Yarn package manager, run:
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update and Upgrade Ubuntu 18.04
RUN apt-get update && apt-get upgrade -y --no-install-recommends 

# Install yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.33.3/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

# Last updates and upgrades
RUN apt-get update && apt-get upgrade

# Cleanup Ubuntu Environment
RUN apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y

ENTRYPOINT [ "/azp/agent/start.pat.sh" ]