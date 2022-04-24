# Azure DevOps Linux Agent OCI Image Creation Steps

## Login with DOCKER / BUILDAH

```shell
$ docker login -u username -p password docker.io
```

```shell
$ buildah login -u username -p password docker.io
```

## Build OCI Image in DOCKER / BUILDAH

```shell
$ docker build -t azuredevops-linux-test-agent-auth-negotiate:2.181.2 -f Build/Dockerfile.testagent.negotiate .

$ docker build -t azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 -f Build/Dockerfile.superagent.negotiate .
```

```shell
$ buildah build -t azuredevops-linux-test-agent-auth-negotiate:2.181.2 -f Build/Dockerfile.testagent.negotiate .

$ docker build -t azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 -f Build/Dockerfile.superagent.pat .
```

## Tag OCI Image in DOCKER / BUILDAH

```shell
$ docker tag azuredevops-linux-test-agent-auth-negotiate:2.181.2 docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2

$ docker tag azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2
```

```shell
$ buildah tag localhost/azuredevops-linux-test-agent-auth-negotiate:2.181.2 docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2

$ buildah tag localhost/azuredevops-linux-agent-auth-negotiate:jdk17-mvn3.8-nodejs16-py3-go1.17-dockercli-buildah-sonarscanner4.6-azp2.181.2 docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2
```

## List Images in DOCKER / BUILDAH

```shell
$ docker images
```

```shell
$ buildah images
```

## Push Images to Docker Hub in DOCKER / BUILDAH

```shell
$ docker push docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2

$ docker push docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2
```

```shell
$ buildah push docker.io/scopeinfra/azuredevops-linux-test-agent-auth-negotiate:2.181.2

$ buildah push docker.io/scopeinfra/azuredevops-linux-agent-auth-negotiate:jdk17-11-8-mvn3.8-nodejs16-12-py3-go1.17-dockercli-buildah-sonarscanner4.6-yarn-helm-azp2.181.2
```
