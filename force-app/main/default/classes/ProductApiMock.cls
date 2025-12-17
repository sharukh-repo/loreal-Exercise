@IsTest
global class ProductApiMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"barcode":"3600523235214","name":"L’Oréal Paris Revitalift Serum","category":"Skincare","expirationDate":"2026-12-30"}');
        return res;
    }
}
