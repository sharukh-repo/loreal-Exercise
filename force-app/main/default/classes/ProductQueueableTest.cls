
@IsTest
private class ProductQueueableTest {

    @IsTest
    static void testExecute_processesBarcodes_andUpsertsProducts() {        
        Test.setMock(HttpCalloutMock.class, new ProductApiMock());
        Set<String> bars = new Set<String>{ '900001', '900002', '900003' };
        ProductQueueable q = new ProductQueueable(bars);
        Test.startTest();
        System.enqueueJob(q);
        Test.stopTest();
        List<Product2__c> prods = [SELECT Id, Barcode__c, Name, Category__c, Expiration_Date__c FROM Product2__c];
        System.assertEquals(1, prods.size());
        Product2__c p = prods[0];
        System.assertEquals('3600523235214', p.Barcode__c, 'Barcode should match fixed mock response');
        System.assertEquals('L’Oréal Paris Revitalift Serum', p.Name, 'Name should match fixed mock response');
        
}
