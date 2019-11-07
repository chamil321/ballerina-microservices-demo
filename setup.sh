ballerina build --sourceroot HipsterShop/ --all --skip-tests
kubectl apply -f  HipsterShop/target/kubernetes/adservice
kubectl apply -f  HipsterShop/target/kubernetes/currencyservice
kubectl apply -f  HipsterShop/target/kubernetes/paymentservice
kubectl apply -f  HipsterShop/target/kubernetes/shippingservice
kubectl apply -f  HipsterShop/target/kubernetes/cartservice
kubectl apply -f  HipsterShop/target/kubernetes/productcatalogservice
kubectl apply -f  HipsterShop/target/kubernetes/checkoutservice
kubectl apply -f  HipsterShop/target/kubernetes/emailservice
kubectl apply -f  HipsterShop/target/kubernetes/recommendationservice
kubectl apply -f frontend/frontend-kubernetes-manifests.yaml
kubectl get services
