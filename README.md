# Azure DevOps Linux Agent OCI Image Creation Steps

## DOCKER

### Login
"
```docker login -u username -p password docker.io```

### Build OCI Image

- Test Agents
  - Negotiate <br>
  ```docker build -t azuredevops-linux-test-agent-auth-negotiate:2.181.2 -f Build/Dockerfile.testagent.negotiate .```
  - PAT <br>
  ```docker build -t azuredevops-linux-test-agent-auth-pat:2.181.2 -f Build/Dockerfile.testagent.pat .```

- Super Agents
  - Negotiate <br>
  ```docker build -t azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 -f Build/Dockerfile.superagent.negotiate .```
  - PAT <br>
  ```docker build -t azuredevops-linux-agent-auth-pat:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 -f Build/Dockerfile.superagent.pat .```

### Tag OCI Image

- Test Agents
  - Negotiate <br>
  ```docker tag azuredevops-linux-test-agent-auth-negotiate:2.181.2 docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2```
  - PAT <br>
  ```docker tag azuredevops-linux-test-agent-auth-pat:2.181.2 docker.io/scopeinfra/azuredevops-linux-test-agent-auth-pat:2.181.2```
- Super Agents
  - Negotiate <br>
  ```docker tag azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```
  - PAT <br>
  ```docker tag azuredevops-linux-agent-auth-pat:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```

### List Images

```docker images```

### Push Images to Docker Hub

- Test Agents
  - Negotiate <br>
  ```docker push docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2```
  - PAT <br>
  ```docker push docker.io/scopeinfra/azuredevops-linux-test-agent-auth-pat:2.181.2```

- Super Agents
  - Negotiate <br>
  ```docker push docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```
  - PAT <br>
  ```docker push docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```

<br>

## BUILDAH

### Login

```buildah login -u username -p password docker.io```

### Build OCI Image

- Test Agents
  - Negotiate <br>
  ```buildah build -t azuredevops-linux-test-agent-auth-negotiate:2.181.2 -f Build/Dockerfile.testagent.negotiate .```
  - PAT <br>
  ```buildah build -t azuredevops-linux-test-agent-auth-pat:2.181.2 -f Build/Dockerfile.testagent.pat .```

- Super Agents
  - Negotiate <br>
  ```buildah build -t azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 -f Build/Dockerfile.superagent.negotiate .```
  - PAT <br>
  ```buildah build -t azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 -f Build/Dockerfile.superagent.pat .```

### Tag OCI Image

- Test Agents
  - Negotiate <br>
  ```buildah tag localhost/azuredevops-linux-test-agent-auth-negotiate:2.181.2 docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2```
  - PAT <br>
  ```buildah tag localhost/azuredevops-linux-test-agent-auth-pat:2.181.2 docker.io/scopeinfra/azuredevops-linux-test-agent-auth-pat:2.181.2```

- Super Agents
  - Negotiate <br>
  ```buildah tag localhost/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```
  - PAT <br>
  ```buildah tag localhost/azuredevops-linux-agent-auth-pat:jdk17-mvn3.8-nodejs16-py3-go1.17-dockercli-buildah-sonarscanner4.6-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```

### List Images

```buildah images```

### Push Images to Docker Hub

- Test Agents
  - Negotiate <br>
  ```buildah push docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2```
  - PAT <br>
  ```buildah push docker.io/scopeinfra/azuredevops-linux-test-agent-auth-pat:2.181.2```

- Super Agents
  - Negotiate <br>
  ```buildah push docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```
  - PAT <br>
  ```buildah push docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:jdk17-11-8-mvn3.8-nodejs16-14-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2```
