# README



### Install dependencies:

First, we need to install and start minikube or other k8s as you like.

```bash
minikube start  
```



Install the [custom-pod-autoscaler](https://github.com/jthomperoo/custom-pod-autoscaler)

```
VERSION=v1.1.0
kubectl apply -f https://github.com/jthomperoo/custom-pod-autoscaler-operator/releases/download/${VERSION}/cluster.yaml
```



### Switch to target the Minikube registry

Target the Minikube registry for building the image:

```bash
eval $(minikube docker-env)
```

### Deploy an app for the CPA to manage

You need to deploy an app for the CPA to manage:

- Build the example app image.

  ```bash
  docker build -t flask-metric ./flask-metric
  ```

- Deploy the app using a deployment.

  ```bash
  kubectl apply -f ./flask-metric/deployment.yaml
  ```

- Deploy the service load-balancer.

  ```bash
  kubectl apply -f ./flask-metric/service.yaml
  ```

- Now you have an app running to manage scaling for.

### Build CPA image

Once CPAs have been enabled on your cluster, you need to build this example, run these commands to build the example:

- Build the example image.

  ```bash
  docker build -t simple-pod-metrics-python .
  ```

- Deploy the CPA using the image just built.

  ```bash
  kubectl apply -f cpa.yaml
  ```

  Now the CPA should be running on your cluster, managing the app we previously deployed.


## Testing the CPA

- List pods.

  ```bash
  kubectl get po
  ```

- Get value.
  `curl -X POST http://EXTERNAL-IP:8000/metric`

- Increment value.
  `curl -X POST http://EXTERNAL-IP:8000/increment`

- Decrement value.
  `curl -X POST http://EXTERNAL-IP:8000/decrement`