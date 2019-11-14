import ballerinaDemo/currencyservice;

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
