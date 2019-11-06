import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "paymentservice"
}  
listener grpc:Listener ep = new grpc:Listener(50051);


service ShippingService on ep {

    resource function GetQuote(grpc:Caller caller, GetQuoteRequest value) {
        // Implementation goes here.

        // You should return a GetQuoteResponse
        Money cost_usd = {currency_code:"USD", units:100, nanos:10};
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

