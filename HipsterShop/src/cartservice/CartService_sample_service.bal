import ballerina/grpc;
import ballerina/kubernetes;
import ballerina/log;

map<Cart> userCarts = {};
final Empty empty = {};

@kubernetes:Service {

    serviceType: "ClusterIP",
    name: "cartservice"
}

@kubernetes:Deployment {
    dockerHost: "tcp://192.168.99.100:2376",
    dockerCertPath: "/home/waruna/.minikube/certs"
}
service CartService on new grpc:Listener(7070) {

    resource function AddItem(grpc:Caller caller, AddItemRequest value) {
        string userId = value.user_id;
        CartItem item = value.item;

        Cart cart;
        if userCarts.hasKey(userId) {
            cart = userCarts.get(userId);

            CartItem? matchedItem = ();

            foreach CartItem ci in cart.items {
                if ci.product_id == item.product_id {
                    matchedItem = ci;
                    break;
                }
            }

            if matchedItem is CartItem {
                matchedItem.quantity += item.quantity;
            } else {
                cart.items.push(item);
            }
        } else {
            cart = {
                user_id: userId,
                items: [item]
            };
            userCarts[userId] = cart;
        }

        log:printInfo("Added item " + item.toString() + " for user ID " + userId);
        var e = caller->send(empty);
        e = caller->complete();
    }

    resource function GetCart(grpc:Caller caller, GetCartRequest value) {
        // Implementation goes here.
        string userId = value.user_id;
        Cart resp;

        if userCarts.hasKey(userId) {
            resp = userCarts.get(userId);
            log:printInfo("Returning cart for user ID: " + userId);
        } else {
            resp = {user_id: userId, items:[]};
            log:printInfo("No cart found for user ID: " + userId + ", returning an empty cart");
        }

        var e = caller->send(resp);
        e = caller->complete();
        // You should return a Cart
    }

    resource function EmptyCart(grpc:Caller caller, EmptyCartRequest value) {
        // Implementation goes here.
        string userId = value.user_id;
        userCarts[userId] = {user_id: userId, items:[]};
        log:printInfo("Empty cart set for user ID: " + userId);
        var e = caller->send(empty);
        e = caller->complete();
        // You should return a Empty
    }
}

