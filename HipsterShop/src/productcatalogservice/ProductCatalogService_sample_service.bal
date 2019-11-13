import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;
import ballerina/log;
import ballerina/stringutils;

Product[] products = [];

function __init() {
    string filePath = "src/productcatalogservice/resources/products.json";

    io:ReadableByteChannel rbc = checkpanic io:openReadableFile(filePath);
    io:ReadableCharacterChannel rch = new(rbc, "UTF8");

    json result = checkpanic rch.readJson();

    products = <@untainted> checkpanic Product[].constructFrom(checkpanic result.products);

    _ = checkpanic rch.close();
    log:printInfo("Reading products.json has completed");
}

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "productcatalogservice"
}  

@kubernetes:Deployment {
    dockerHost: "tcp://192.168.99.100:2376",
    dockerCertPath: "/home/waruna/.minikube/certs"
}

service ProductCatalogService on new grpc:Listener(3550) {

    resource function ListProducts(grpc:Caller caller) {

        // You should return a ListProductsResponse
        ListProductsResponse resp = {
            products: products
        };
        log:printInfo("Responding with product list:" + resp.toString());
        var e = caller->send(resp);
        e = caller->complete();
    }

    resource function GetProduct(grpc:Caller caller, GetProductRequest value) {

        // You should return a Product
        Product? matchedItem = ();
        string product_id = value.id;

        foreach Product item in products {
            if item.id == product_id {
                matchedItem = item;
                log:printInfo("Product found:" + item.toString());
                break;
            }
        }

        if matchedItem is Product {
            var e = caller->send(matchedItem);
            e = caller->complete();
        } else {
            log:printError("No product with ID " + product_id);
            // TODO: Respond with error or what???
        }
    }

    resource function SearchProducts(grpc:Caller caller, SearchProductsRequest value) {

        // You should return a SearchProductsResponse
        Product[] searchedProducts = [];
        string query = value.query;

        foreach Product item in products {
            if stringutils:contains(item.name, query) || stringutils:contains(item.description, query) {
                searchedProducts.push(item);
            }
        }

        SearchProductsResponse resp = {
            results: searchedProducts
        };
        log:printInfo("Responding with product list:" + resp.toString());
        var e = caller->send(resp);
        e = caller->complete();
    }
}
