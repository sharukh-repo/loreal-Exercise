
@IsTest
private class CaseTriggerTest {

    @IsTest
    static void testAfterInsert_enqueuesQueueable_forValidBarcode() {
        Test.setMock(HttpCalloutMock.class, new ProductApiMock());
        Account acc = new Account(
            Name = 'Test Consumer3'
        );
        insert acc;
        List<Case> casesToInsert = new List<Case>{
            new Case(Subject = 'Case 1',AccountId = acc.Id, Origin = 'Phone', Product_Barcode__c = '111111'),
            new Case(Subject = 'Case 2',AccountId = acc.Id, Origin = 'Email', Product_Barcode__c = null),
            new Case(Subject = 'Case 3',AccountId = acc.Id, Origin = 'Web', Product_Barcode__c = '222222')
        };
        Test.startTest();
        insert casesToInsert;
        Test.stopTest();
        Integer countProds = [SELECT count() FROM Product2__c WHERE Barcode__c = '3600523235214'];
        System.assertEquals(1, countProds);
    }
    
}
