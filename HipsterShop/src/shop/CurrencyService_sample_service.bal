import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;

string[] currency_codes = ["EUR","USD","JPY","BGN","CZK","SGD","THB","ZAR"];

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "currencyservice"
}  
service CurrencyService on new grpc:Listener(7000) {

    resource function GetSupportedCurrencies(grpc:Caller caller, Empty value) {
        // Implementation goes here.

        // You should return a GetSupportedCurrenciesResponse
        GetSupportedCurrenciesResponse resp = {currency_codes:currency_codes};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
    resource function Convert(grpc:Caller caller, CurrencyConversionRequest value) {
        // Implementation goes here.

        // You should return a Money
        Money resp = {currency_code:value.to_code, units:20, nanos:10};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}

