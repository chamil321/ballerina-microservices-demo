import ballerina/grpc;
import ballerina/io;

  
service PaymentService on ep {

    resource function Charge(grpc:Caller caller, ChargeRequest value) {
        ChargeResponse resp = {transaction_id:"12345678"};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}

