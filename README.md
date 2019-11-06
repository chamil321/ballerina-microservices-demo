# Hipster Shop: Cloud-Native Microservices Demo Application

This project contains a 10-tier microservices application. The application is a
web-based e-commerce app called **“Hipster Shop”** where users can browse items,
add them to the cart, and purchase them.


## How to run

1) Clone the repo
2) Change @kubernetes:Deployment config as per your configuration.

```
@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}
```

3) run ballerina build --sourceroot HipsterShop/ -a
4) kubectl apply -f /home/waruna/dev/ballerina/git/ballerina-microservcies-demo/HipsterShop/target/kubernetes/shop
5) kubectl apply -f frontend/frontend-kubernetes-manifests.yaml
