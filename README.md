# Hipster Shop: Cloud-Native Microservices Demo Application

This project contains a 10-tier microservices application. The application is a
web-based e-commerce app called **“Hipster Shop”** where users can browse items,
add them to the cart, and purchase them.


## How to run

1. Clone the repository.
2. Change @kubernetes:Deployment config as per your configuration.

```
@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}
```

3. Execute setup.sh script.

```
sh setup.sh
```
4. Find the IP address of your application, then visit the application on your browser to confirm installation.

kubectl get service/frontend-external 
