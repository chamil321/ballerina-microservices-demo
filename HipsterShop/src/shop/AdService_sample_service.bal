import ballerina/grpc;
import ballerina/io;
import ballerina/math;
import ballerina/kubernetes;

@kubernetes:Service {
    serviceType: "ClusterIP",
    name: "adservice"
}

@kubernetes:Deployment {
    dockerHost:"tcp://192.168.99.100:2376", 
    dockerCertPath:"/home/waruna/.minikube/certs"
}


service AdService on new grpc:Listener(9555) {
    resource function GetAds(grpc:Caller caller, AdRequest adRequest) {
        Ad[] ads = [];
        if adRequest.context_keys.length() > 0 {
            io:println("Constructing Ads using context");
            foreach var key in adRequest.context_keys {
                var adsFound = adsMap[key];
                if adsFound is Ad[] {
                    ads.push(...adsFound);
                }
            }
            if ads.length() == 0 {
                io:println("No Ads found based on context. Constructing random Ads.");
                ads = getRandomAds();
            }
        } else {
            io:println("No context provided. Constructing random Ads.");
            ads = getRandomAds();
        }

        // You should return a AdResponse
        AdResponse resp = {ads: ads};
        io:println(resp);
        var e = caller->send(resp);
        e = caller->complete();
    }
}


Ad camera = {redirect_url: "/product/2ZYFJ3GM2N", text: "Film camera for sale. 50% off."};
Ad lens = {redirect_url: "/product/66VCHSJNUP", text: "Vintage camera lens for sale. 20% off."};
Ad recordPlayer = {redirect_url: "/product/0PUK6V6EV0", text: "Vintage record player for sale. 30% off."};
Ad bike = {redirect_url: "/product/9SIQT8TOJO", text: "City Bike for sale. 10% off."};
Ad baristaKit = {redirect_url: "/product/1YMWWN1N4O", text: "Home Barista kitchen kit for sale. Buy one, get second kit for free"};
Ad airPlant = {redirect_url: "/product/6E92ZMYYFZ", text: "Air plants for sale. Buy two, get third one for free"};
Ad terrarium = {redirect_url: "/product/L9ECAV7KIM", text: "Terrarium for sale. Buy one, get second one for free"};

map<Ad[]> adsMap = {"photography": [camera, lens], "vintage": [camera, lens, recordPlayer], "cycling": [bike], "cookware": [baristaKit], "gardening": [airPlant, terrarium]};

const MAX_ADS_TO_SERVE = 2;

function getRandomAds() returns Ad[] {
    var keys = adsMap.keys();
    Ad[] randomAds = [];
    foreach var i in 0 ..< MAX_ADS_TO_SERVE {
        // TODO Why this method returns an error https://ballerina.io/learn/api-docs/ballerina/math/functions.html#randomInRange
        var key = keys[checkpanic math:randomInRange(0, keys.length())];
        var ads = adsMap.get(key);
        var randomAd = ads[checkpanic math:randomInRange(0, ads.length())];
        randomAds.push(randomAd);
    }
    return randomAds;
}

