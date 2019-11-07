import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;
  
@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "paymentservice"
} 

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}
service PaymentService on new grpc:Listener(50051) {

    resource function Charge(grpc:Caller caller, ChargeRequest value) {
        ChargeResponse resp = {transaction_id:"12345678"};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}

