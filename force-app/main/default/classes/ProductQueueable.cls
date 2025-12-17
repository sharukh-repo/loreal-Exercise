public with sharing class ProductQueueable implements Queueable, Database.AllowsCallouts {

    private Set<String> barcodes;

    public ProductQueueable(Set<String> barcodes) {
        this.barcodes = barcodes == null ? new Set<String>() : barcodes;
    }

    public void execute(QueueableContext context) {
        if (barcodes == null || barcodes.isEmpty()) {
            return;
        }
        for(string str:barcodes){
          ProductCallout.fetchProduct(str);
        }
    }
}
