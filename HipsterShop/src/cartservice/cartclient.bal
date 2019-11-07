import ballerina/grpc;

public type CartServiceBlockingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        grpc:Client c = new(url, config);
        grpc:Error? result = c.initStub(self, "blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is grpc:Error) {
            error err = result;
            panic err;
        } else {
            self.grpcClient = c;
        }
    }

    public remote function AddItem(AddItemRequest req, grpc:Headers? headers = ()) returns ([Empty, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("hipstershop.CartService/AddItem", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        var value = typedesc<Empty>.constructFrom(result);
        if (value is Empty) {
            return [value, resHeaders];
        } else {
            return grpc:prepareError(grpc:INTERNAL_ERROR, "Error while constructing the message", value);
        }
    }

    public remote function GetCart(GetCartRequest req, grpc:Headers? headers = ()) returns ([Cart, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("hipstershop.CartService/GetCart", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        var value = typedesc<Cart>.constructFrom(result);
        if (value is Cart) {
            return [value, resHeaders];
        } else {
            return grpc:prepareError(grpc:INTERNAL_ERROR, "Error while constructing the message", value);
        }
    }

    public remote function EmptyCart(EmptyCartRequest req, grpc:Headers? headers = ()) returns ([Empty, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("hipstershop.CartService/EmptyCart", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        var value = typedesc<Empty>.constructFrom(result);
        if (value is Empty) {
            return [value, resHeaders];
        } else {
            return grpc:prepareError(grpc:INTERNAL_ERROR, "Error while constructing the message", value);
        }
    }

};

public type CartServiceClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        grpc:Client c = new(url, config);
        grpc:Error? result = c.initStub(self, "non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is grpc:Error) {
            error err = result;
            panic err;
        } else {
            self.grpcClient = c;
        }
    }

    public remote function AddItem(AddItemRequest req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("hipstershop.CartService/AddItem", req, msgListener, headers);
    }

    public remote function GetCart(GetCartRequest req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("hipstershop.CartService/GetCart", req, msgListener, headers);
    }

    public remote function EmptyCart(EmptyCartRequest req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("hipstershop.CartService/EmptyCart", req, msgListener, headers);
    }

};

public type CartItem record {|
    string product_id;
    int quantity;
    
|};


public type AddItemRequest record {|
    string user_id;
    CartItem item;
    
|};


public type EmptyCartRequest record {|
    string user_id;
    
|};


public type GetCartRequest record {|
    string user_id;
    
|};


public type Cart record {|
    string user_id;
    CartItem[] items;
    
|};


public type Empty record {|
    
|};


const string ROOT_DESCRIPTOR = "0A1163617274736572766963652E70726F746F120B6869707374657273686F7022450A08436172744974656D121D0A0A70726F647563745F6964180120012809520970726F647563744964121A0A087175616E7469747918022001280552087175616E7469747922540A0E4164644974656D5265717565737412170A07757365725F6964180120012809520675736572496412290A046974656D18022001280B32152E6869707374657273686F702E436172744974656D52046974656D222B0A10456D707479436172745265717565737412170A07757365725F6964180120012809520675736572496422290A0E476574436172745265717565737412170A07757365725F69641801200128095206757365724964224C0A044361727412170A07757365725F69641801200128095206757365724964122B0A056974656D7318022003280B32152E6869707374657273686F702E436172744974656D52056974656D7322070A05456D70747932CA010A0B4361727453657276696365123C0A074164644974656D121B2E6869707374657273686F702E4164644974656D526571756573741A122E6869707374657273686F702E456D7074792200123B0A0747657443617274121B2E6869707374657273686F702E47657443617274526571756573741A112E6869707374657273686F702E43617274220012400A09456D70747943617274121D2E6869707374657273686F702E456D70747943617274526571756573741A122E6869707374657273686F702E456D7074792200620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "cartservice.proto":"0A1163617274736572766963652E70726F746F120B6869707374657273686F7022450A08436172744974656D121D0A0A70726F647563745F6964180120012809520970726F647563744964121A0A087175616E7469747918022001280552087175616E7469747922540A0E4164644974656D5265717565737412170A07757365725F6964180120012809520675736572496412290A046974656D18022001280B32152E6869707374657273686F702E436172744974656D52046974656D222B0A10456D707479436172745265717565737412170A07757365725F6964180120012809520675736572496422290A0E476574436172745265717565737412170A07757365725F69641801200128095206757365724964224C0A044361727412170A07757365725F69641801200128095206757365724964122B0A056974656D7318022003280B32152E6869707374657273686F702E436172744974656D52056974656D7322070A05456D70747932CA010A0B4361727453657276696365123C0A074164644974656D121B2E6869707374657273686F702E4164644974656D526571756573741A122E6869707374657273686F702E456D7074792200123B0A0747657443617274121B2E6869707374657273686F702E47657443617274526571756573741A112E6869707374657273686F702E43617274220012400A09456D70747943617274121D2E6869707374657273686F702E456D70747943617274526571756573741A122E6869707374657273686F702E456D7074792200620670726F746F33"
        
    };
}
