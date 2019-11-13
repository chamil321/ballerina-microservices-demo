import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;

string[] currency_codes = ["EUR","USD","JPY","BGN","CZK","SGD","THB","ZAR"];

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "currencyservice"
}  

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}

service CurrencyService on new grpc:Listener(7000) {

    resource function GetSupportedCurrencies(grpc:Caller caller) {
        // Implementation goes here.
        io:println("**********************");
        // You should return a GetSupportedCurrenciesResponse
        GetSupportedCurrenciesResponse resp = {currency_codes:currency_codes};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
    resource function Convert(grpc:Caller caller, CurrencyConversionRequest value) {
        // Implementation goes here.

        // You should return a Money
        Money resp = {currencyCode:value.to_code, units:20, nanos:10};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}

