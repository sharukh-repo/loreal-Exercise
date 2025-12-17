public with sharing class ProductController {

    @AuraEnabled(cacheable=true)
    public static srkApp__Product__c getProduct(String barcode) {
        return [
            SELECT Name, srkApp__Category__c, srkApp__Expiration_Date__c
            FROM  srkApp__Product__c
            WHERE srkApp__Barcode__c = :barcode
            LIMIT 1
        ];
    }
}
