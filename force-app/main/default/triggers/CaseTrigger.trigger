trigger CaseTrigger on Case (after insert,after update) {
   Set<String> barcodes = new Set<String>();
   for (Case c : Trigger.new) {
    if (c.Product_Barcode__c != null) {
        barcodes.add(c.Product_Barcode__c);
    }
   }
    if (!barcodes.isEmpty()) {
    System.enqueueJob(new ProductQueueable(barcodes));
     }

}