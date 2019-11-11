import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;
import ballerinaDemo/cartservice;
import ballerinaDemo/productcatalogservice;

// Product catalog client.
productcatalogservice:ProductCatalogServiceBlockingClient productCat = new ("http://productcatalogservice:3550");

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "recommendationservice"
}

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376",
    dockerCertPath:"/home/waruna/.minikube/certs"
}

service RecommendationService on new grpc:Listener(8080) {

    resource function ListRecommendations(grpc:Caller caller, ListRecommendationsRequest value) {
        int max_responses = 5;

        cartservice:Empty req = {};
        // Fetch list of products from product catalog stub
        var products = productCat->ListProducts(req);
        if (products is grpc:Error) {
            io:println("Error from Connector: " + products.reason() + " - "
            + <string>products.detail()["message"]);

            // You should return a ListRecommendationsResponse
            ListRecommendationsRequest resp = {
                user_id: value.user_id,
                product_ids: ["9SIQT8TOJO", "6E92ZMYYFZ", "LS4PSXUNUM"]
            };
            io:println(resp);
            var e = caller->send(resp);
            e = caller->complete();
        } else {
            productcatalogservice:ListProductsResponse listProductResponse;
            grpc:Headers headers;
            [listProductResponse, headers] = products;
            productcatalogservice:Product[] productList = listProductResponse.products;
            string[] productIds = [];

            int i = 0;
            foreach productcatalogservice:Product v in productList {
                productIds[i] = v.id;
                i += 1;
            }

            // Filter products which already available in the request.
            string[] filtered_products = [];
            int j = 0;
            foreach string item in productIds {
                boolean isExist = false;
                foreach string v in value.product_ids {
                    if (item == v) {
                        isExist = true;
                    }
                }
                if (!isExist) {
                    filtered_products[j] = item;
                    j += 1;
                }
            }

            // Send the list of recommentations
            ListRecommendationsRequest resp = {
                user_id: value.user_id,
                product_ids: filtered_products.reverse()
            };
            io:println(resp);
            var e = caller->send(resp);
            e = caller->complete();
        }
    }
}

