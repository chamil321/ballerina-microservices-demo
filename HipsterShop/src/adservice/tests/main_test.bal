import ballerina/io;
import ballerina/test;
import ballerina/grpc;
# Before Suite Function

@test:BeforeSuite
function beforeSuiteFunc() {
    io:println("I'm the before suite function!");
}

# Before test function

function beforeFunc() {
    io:println("I'm the before function!");
}

# Test function

@test:Config {
    before: "beforeFunc",
    after: "afterFunc"
}
function testFunction() {
    io:println("I'm in test function!");
    AdServiceBlockingClient adc = new("http://localhost:9555");
    string[] context_keys = ["photography","vintage","cycling","cookware"];
    AdRequest adr = {context_keys:context_keys};
    var response = adc-> GetAds(adr);
    if (response is grpc:Error) {
            io:println("Error from Connector: " + response.reason() + " - "
                    + <string> response.detail()["message"]);
    } else {
        AdResponse result;
        grpc:Headers resHeaders;
        [result, resHeaders] = response;
        io:println("Client Got Response : " + result.toString());
    }
}

# After test function

function afterFunc() {
    io:println("I'm the after function!");
}

# After Suite Function

@test:AfterSuite
function afterSuiteFunc() {
    io:println("I'm the after suite function!");
}
