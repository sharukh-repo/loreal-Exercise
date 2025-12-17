
@IsTest
private class CaseTriggerTest {

    @IsTest
    static void testAfterInsert_enqueuesQueueable_forValidBarcode() {
        Test.setMock(HttpCalloutMock.class, new ProductApiMock());
        List<Case> casesToInsert = new List<Case>{
            new Case(Subject = 'Case 1', Origin = 'Phone', Product_Barcode__c = '111111'),
            new Case(Subject = 'Case 2', Origin = 'Email', Product_Barcode__c = null),
            new Case(Subject = 'Case 3', Origin = 'Web', Product_Barcode__c = '222222')
        };

        Test.startTest();
        insert casesToInsert;
        List<System.AsyncApexJob> jobs = [SELECT Id, JobType, Status, ApexClass.Name FROM AsyncApexJob WHERE JobType = 'Queueable' ORDER BY CreatedDate DESC];
        System.assert(!jobs.isEmpty());
        Test.stopTest();
        Integer countProds = [SELECT count() FROM Product2__c WHERE Barcode__c = '3600523235214'];
        System.assertEquals(1, countProds);
    }

    @IsTest
    static void testAfterUpdate_enqueuesQueueable_whenBarcodeSetOrChanged() {
        Test.setMock(HttpCalloutMock.class, new ProductApiMock());
        Case c = new Case(Subject = 'Needs Update', Origin = 'Phone');
        insert c;
        c.Product_Barcode__c = '333333';
        Test.startTest();
        update c;
        List<System.AsyncApexJob> jobs = [SELECT Id, JobType, Status, ApexClass.Name FROM AsyncApexJob WHERE JobType = 'Queueable' ORDER BY CreatedDate DESC];
        System.assert(!jobs.isEmpty());
        Test.stopTest();
    }

    @IsTest
    static void testNoEnqueue_whenAllBarcodesNullOrBlank() {
        List<Case> toInsert = new List<Case>{
            new Case(Subject = 'No Barcode 1', Origin = 'Email', Product_Barcode__c = null),
            new Case(Subject = 'No Barcode 2', Origin = 'Web') 
        };
        Test.startTest();
        insert toInsert;
        List<System.AsyncApexJob> jobs = [SELECT Id FROM AsyncApexJob WHERE JobType = 'Queueable' ORDER BY CreatedDate DESC];
        Test.stopTest();
        System.assertEquals(0, jobs.size());
    }

    
}
