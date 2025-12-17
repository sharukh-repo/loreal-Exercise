import { LightningElement } from 'lwc';
import getProduct from '@salesforce/apex/ProductController.getProduct';

export default class ProductScanner extends LightningElement {
    barcode;
    product;
    isLoading = false;
    errorMessage;

    handleChange(event) {
        this.barcode = event.target.value;
        this.errorMessage = null; // clear prior errors when user types
    }

    handleSearch() {
        // basic validation
        if (!this.barcode || !this.barcode.trim()) {
            this.errorMessage = 'Please enter a barcode before searching.';
            this.product = undefined;
            return;
        }

        this.isLoading = true;
        this.errorMessage = null;

        getProduct({ barcode: this.barcode })
            .then(result => {
                if (result) {
                    console.log('result', result);
                    this.product = result;
                    this.errorMessage = null;
                } else {
                    this.product = undefined;
                    this.errorMessage = 'No product found for the provided barcode.';
                }
            })
            .catch(() => {
                this.product = undefined;
                this.errorMessage = 'Something went wrong while fetching the product. Please try again.';
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}
