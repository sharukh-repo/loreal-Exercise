public with sharing class ProductCallout {

    public static void fetchProduct(String barcode) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:PIM_API/api/v1/products/' + barcode);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() != 200) {
            System.debug('API Error: ' + res.getBody());
        }

        Map<String, Object> data =
            (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('data is '+data);

        Product2__c p = new Product2__c(
            Barcode__c = (String) data.get('barcode'),
            Name = (String) data.get('name'),
            Category__c = (String) data.get('category'),
            Expiration_Date__c =
                Date.valueOf((String) data.get('expirationDate'))
        );
        // upserting using the barcode as the external id

        upsert p Barcode__c;
        
    }

}