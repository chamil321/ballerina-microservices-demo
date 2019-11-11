import ballerina/grpc;
import ballerinaDemo/currencyservice;
import ballerinaDemo/cartservice;

public type ProductCatalogServiceBlockingClient client object {

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

    public remote function ListProducts(cartservice:Empty req, grpc:Headers? headers = ()) returns ([ListProductsResponse, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("hipstershop.ProductCatalogService/ListProducts", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        var value = typedesc<ListProductsResponse>.constructFrom(result);
        if (value is ListProductsResponse) {
            return [value, resHeaders];
        } else {
            return grpc:prepareError(grpc:INTERNAL_ERROR, "Error while constructing the message", value);
        }
    }

    public remote function GetProduct(GetProductRequest req, grpc:Headers? headers = ()) returns ([Product, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("hipstershop.ProductCatalogService/GetProduct", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        var value = typedesc<Product>.constructFrom(result);
        if (value is Product) {
            return [value, resHeaders];
        } else {
            return grpc:prepareError(grpc:INTERNAL_ERROR, "Error while constructing the message", value);
        }
    }

    public remote function SearchProducts(SearchProductsRequest req, grpc:Headers? headers = ()) returns ([SearchProductsResponse, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("hipstershop.ProductCatalogService/SearchProducts", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        var value = typedesc<SearchProductsResponse>.constructFrom(result);
        if (value is SearchProductsResponse) {
            return [value, resHeaders];
        } else {
            return grpc:prepareError(grpc:INTERNAL_ERROR, "Error while constructing the message", value);
        }
    }

};

public type ProductCatalogServiceClient client object {

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

    public remote function ListProducts(cartservice:Empty req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("hipstershop.ProductCatalogService/ListProducts", req, msgListener, headers);
    }

    public remote function GetProduct(GetProductRequest req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("hipstershop.ProductCatalogService/GetProduct", req, msgListener, headers);
    }

    public remote function SearchProducts(SearchProductsRequest req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("hipstershop.ProductCatalogService/SearchProducts", req, msgListener, headers);
    }

};


public type CartItem record {|
    string product_id;
    int quantity;
    
|};



public type Product record {|
    string id;
    string name;
    string description;
    string picture;
    currencyservice:Money price_usd;
    string[] categories;
    
|};


public type ListProductsResponse record {|
    Product[] products;
    
|};


public type GetProductRequest record {|
    string id;
    
|};


public type SearchProductsRequest record {|
    string query;
    
|};


public type SearchProductsResponse record {|
    Product[] results;
    
|};

const string ROOT_DESCRIPTOR = "0A1B70726F64756374636174616C6F67736572766963652E70726F746F120B6869707374657273686F7022580A054D6F6E657912230A0D63757272656E63795F636F6465180120012809520C63757272656E6379436F646512140A05756E6974731802200128035205756E69747312140A056E616E6F7318032001280552056E616E6F7322070A05456D70747922BA010A0750726F64756374120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12180A0770696374757265180420012809520770696374757265122F0A0970726963655F75736418052001280B32122E6869707374657273686F702E4D6F6E657952087072696365557364121E0A0A63617465676F72696573180620032809520A63617465676F7269657322480A144C69737450726F6475637473526573706F6E736512300A0870726F647563747318012003280B32142E6869707374657273686F702E50726F64756374520870726F647563747322230A1147657450726F6475637452657175657374120E0A02696418012001280952026964222D0A1553656172636850726F64756374735265717565737412140A0571756572791801200128095205717565727922480A1653656172636850726F6475637473526573706F6E7365122E0A07726573756C747318012003280B32142E6869707374657273686F702E50726F647563745207726573756C74733283020A1550726F64756374436174616C6F675365727669636512470A0C4C69737450726F647563747312122E6869707374657273686F702E456D7074791A212E6869707374657273686F702E4C69737450726F6475637473526573706F6E7365220012440A0A47657450726F64756374121E2E6869707374657273686F702E47657450726F64756374526571756573741A142E6869707374657273686F702E50726F647563742200125B0A0E53656172636850726F647563747312222E6869707374657273686F702E53656172636850726F6475637473526571756573741A232E6869707374657273686F702E53656172636850726F6475637473526573706F6E73652200620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "productcatalogservice.proto":"0A1B70726F64756374636174616C6F67736572766963652E70726F746F120B6869707374657273686F7022580A054D6F6E657912230A0D63757272656E63795F636F6465180120012809520C63757272656E6379436F646512140A05756E6974731802200128035205756E69747312140A056E616E6F7318032001280552056E616E6F7322070A05456D70747922BA010A0750726F64756374120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12180A0770696374757265180420012809520770696374757265122F0A0970726963655F75736418052001280B32122E6869707374657273686F702E4D6F6E657952087072696365557364121E0A0A63617465676F72696573180620032809520A63617465676F7269657322480A144C69737450726F6475637473526573706F6E736512300A0870726F647563747318012003280B32142E6869707374657273686F702E50726F64756374520870726F647563747322230A1147657450726F6475637452657175657374120E0A02696418012001280952026964222D0A1553656172636850726F64756374735265717565737412140A0571756572791801200128095205717565727922480A1653656172636850726F6475637473526573706F6E7365122E0A07726573756C747318012003280B32142E6869707374657273686F702E50726F647563745207726573756C74733283020A1550726F64756374436174616C6F675365727669636512470A0C4C69737450726F647563747312122E6869707374657273686F702E456D7074791A212E6869707374657273686F702E4C69737450726F6475637473526573706F6E7365220012440A0A47657450726F64756374121E2E6869707374657273686F702E47657450726F64756374526571756573741A142E6869707374657273686F702E50726F647563742200125B0A0E53656172636850726F647563747312222E6869707374657273686F702E53656172636850726F6475637473526571756573741A232E6869707374657273686F702E53656172636850726F6475637473526573706F6E73652200620670726F746F33"
        
    };
}
