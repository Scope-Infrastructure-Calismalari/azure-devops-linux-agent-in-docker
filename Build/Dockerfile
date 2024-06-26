## SCOPE INFRA AZURE DEVOPS LINUX AGENT VERSION: 2.2-azp3.232.1
FROM scopeinfra/azuredevops-linux-agent-auth-pat:2.1-azp3.232.1

USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

## Install trivy-a comprehensive and versatile security scanner
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/trivy.list
RUN apt-get update && apt-get install trivy
RUN trivy image --download-db-only && trivy image --download-java-db-only

## mkdocs-material python library
RUN pip install mkdocs-material

# Last updates and upgrades
RUN apt-get update && apt-get upgrade

# Cleanup Ubuntu Environment
RUN apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y

ENTRYPOINT [ "/azp/agent/start.pat.sh" ]