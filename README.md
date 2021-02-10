# CML with cloud compute


This repository contains a sample project using [CML](https://github.com/iterative/cml) with [Docker Machine](https://docs.docker.com/machine/overview/) to launch an AWS EC2 instance and then run a neural style transfer on that instance. On a pull request, the following actions will occur:
- GitHub will deploy a runner with a custom CML Docker image
- Docker Machine will provision an EC2 instance and pass the neural style transfer workflow to it. DVC is used to version the workflow and dependencies. 
- Neural style transfer will be executed on the EC2 instance 
- CML will report results of the style transfer as a comment in the pull request. 

The key file enabling these actions is `.github/workflows/cml.yaml`.

## Running on Kubernetes

Build the Docker image and push to a repository. This image builds on top of `dvcorg/cml-gpu-py3-cloud-runner` and adds an entrypoint that runs the DVC pipeline.

```
docker build -t dvc-demo -f docker/Dockerfile .
docker tag dvc-demo ghcr.io/jeremyjordan/dvc-demo:0.1
docker push ghcr.io/jeremyjordan/dvc-demo:0.1
```

Spin up a Kubernetes cluster and add a secret for your Github token.

```
minikube start --driver=docker
kubectl create secret generic repo-token-secret --from-literal=repo_token='INSERT_TOKEN_HERE'
```

Submit the style transfer job to the cluster.

```
kubectl apply -f .k8s/style-transfer-job.yaml 
```

Alternatively, you can run the Docker image outside of Kubernetes.

```
docker run -it -e repo_token=INSERT_TOKEN_HERE dvc-demo
```
