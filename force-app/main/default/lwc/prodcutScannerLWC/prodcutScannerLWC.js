import { LightningElement, track } from 'lwc';
import getProduct from '@salesforce/apex/ProductController.getProduct';

export default class ProductScanner extends LightningElement {

    @track barcode;
    @track product;

    handleChange(event) {
        this.barcode = event.target.value;
    }

    handleSearch() {
        getProduct({ barcode: this.barcode })
            .then(result => {
                this.product = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    
}
