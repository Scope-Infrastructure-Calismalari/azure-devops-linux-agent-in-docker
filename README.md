# Azure DevOps Linux Agent OCI Image Creation Steps

## DOCKER

### Login
"
```docker login -u username -p password docker.io```

### Build OCI Image

- Super Agents
  - PAT <br>
  ```docker build -t azuredevops-linux-agent-auth-pat:<version-number>-azp2.181.2 -f Build/Dockerfile.superagent.pat .```

### Tag OCI Image

- Super Agents
  - PAT <br>
  ```docker tag azuredevops-linux-agent-auth-pat:<version-number>-azp2.181.2```

### List Images

```docker images```

### Push Images to Docker Hub

- Super Agents
  - PAT <br>
  ```docker push docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:<version-number>-azp2.181.2```

<br>

## BUILDAH

### Login

```buildah login -u username -p password docker.io```

### Build OCI Image

 - Super Agents
   - PAT <br>
  ```buildah build -t azuredevops-linux-agent-auth-negotiate:<version-number>-azp2.181.2 -f Build/Dockerfile.superagent.pat .```

### Tag OCI Image

- Super Agents
   - PAT <br>
  ```buildah tag localhost/azuredevops-linux-agent-auth-pat:<version-number>-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:<version-number>-azp2.181.2```

### List Images

```buildah images```

### Push Images to Docker Hub

- Super Agents
  - PAT <br>
  ```buildah push docker.io/scopeinfra/azuredevops-linux-agent-auth-pat:<version-number>-azp2.181.2```
