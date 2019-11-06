import ballerina/grpc;
import ballerina/io;
import ballerina/kubernetes;

@kubernetes:Service {

    serviceType: "ClusterIP",
    name: "checkoutservice"
}
service CheckoutService on new grpc:Listener(5050) {
    resource function PlaceOrder(grpc:Caller caller, PlaceOrderRequest value) {
        // Implementation goes here.
        // Calling other servcies like email, payment need to be implemented.
        // You should return a PlaceOrderResponse

    Cart? cart = userCarts.get(value.user_id);
    CartItem[] items = [];
    OrderItem[] oItems = [];
    Money item_cost = {currency_code:"USD", units:2, nanos:10};
    if (cart is Cart) {
        items = cart.items;
    }

    foreach var item in items {
        OrderItem o = {item:item, cost:item_cost};
        oItems.push(o);
    }

    Cart userCart = <Cart>cart;
    Money shipping_cost = {currency_code:"USD", units:1000, nanos:10};
    Address address = { street_address:"Pagoda road",city:"Nugegoda",state:"CMB",
    country:"SL", zip_code:10250};
    
    OrderResult or = {order_id:"o1234", shipping_tracking_id:"tracking9876",
                        shipping_cost:shipping_cost, shipping_address:address,
                        items:oItems};               
    PlaceOrderResponse resp = {'order:or};
    io:println(resp);
    var e = caller->send(resp);
    e = caller->complete();
    }
}


