import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "emailservice"
} 

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}

service EmailService on new grpc:Listener(5000) {

    resource function SendOrderConfirmation(grpc:Caller caller, SendOrderConfirmationRequest value) {
        // Implementation goes here.
        io:println("Confirmation email sent: " + value.toString());
        // You should return a Empty
    }
}

