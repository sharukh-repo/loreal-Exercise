public class ProductController {
    
    @AuraEnabled(cacheable=true)
    public static Product2__c getProduct(String barcode) {
        
        if (String.isBlank(barcode)) {
            return null;
        }

        List<Product2__c> products = [
            SELECT Id, Name, Barcode__c, Expiration_Date__c, Category__c
            FROM Product2__c
            WHERE Barcode__c = :barcode
            LIMIT 1
        ];
        return products.isEmpty() ? null : products[0];
    }
}
