import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "recommendationservice"
}  
service RecommendationService on new grpc:Listener(8080) {

    resource function ListRecommendations(grpc:Caller caller, ListRecommendationsRequest value) {
        // Implementation goes here.

        // You should return a ListRecommendationsResponse

        ListRecommendationsRequest resp = {user_id:value.user_id,
                product_ids:["OLJCESPC7Z", "9SIQT8TOJO", "L9ECAV7KIM"]
        };
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}

