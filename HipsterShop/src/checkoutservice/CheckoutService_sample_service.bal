import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;
import ballerinaDemo/cartservice;
import ballerinaDemo/currencyservice;
import ballerinaDemo/emailservice;
import ballerinaDemo/shippingservice;

cartservice:CartServiceBlockingClient cs = new("http://cartservice:7070");

@kubernetes:Service {

    serviceType: "ClusterIP",
    name: "checkoutservice"
}

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}

service CheckoutService on new grpc:Listener(5050) {
    resource function PlaceOrder(grpc:Caller caller, PlaceOrderRequest value) {
        // Implementation goes here.
        // Calling other servcies like email, payment need to be implemented.
        // You should return a PlaceOrderResponse
        
        cartservice:GetCartRequest getCart = {user_id:value.user_id};
        var response = cs-> GetCart(getCart);
        if (response is grpc:Error) {
            io:println("Error from Connector: " + response.reason() + " - "
                                             + <string> response.detail()["message"]);
            var e = caller->send(<string> response.detail()["message"]);
            e = caller->complete();
        } else {
            cartservice:Cart cart;
            grpc:Headers resHeaders;
            [cart, resHeaders] = response;
            cartservice:CartItem[] items = [];
            emailservice:OrderItem[] oItems = [];
            currencyservice:Money item_cost = {currency_code:"USD", units:2, nanos:10};
            items = cart.items;
            
            foreach var item in items {
                emailservice:OrderItem o = {item:item, cost:item_cost};
                oItems.push(o);
            }

            currencyservice:Money shipping_cost = {currency_code:"USD", units:1000, nanos:10};
            shippingservice:Address address = value.address;
            
            emailservice:OrderResult or = {order_id:"o1234", shipping_tracking_id:"tracking9876",
                                shipping_cost:shipping_cost, shipping_address:address,
                                items:oItems};               
            PlaceOrderResponse resp = {'order:or};
            io:println(resp);
            var e = caller->send(resp);
            e = caller->complete();
        
        }
    }
}


