import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;
import ballerinaDemo/currencyservice;
 
@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "shippingservice"
} 

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}
service ShippingService on new grpc:Listener(50051) {

    resource function GetQuote(grpc:Caller caller, GetQuoteRequest value) {
        // Implementation goes here.

        // You should return a GetQuoteResponse
        currencyservice:Money cost_usd = {currency_code:"USD", units:100, nanos:10};
        GetQuoteResponse resp = {
            cost_usd: cost_usd   
        };
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
 
    }
    resource function ShipOrder(grpc:Caller caller, ShipOrderRequest value) {
        // Implementation goes here.

        // You should return a ShipOrderResponse
         ShipOrderResponse resp = {
            tracking_id:"123456"  
        };
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}

