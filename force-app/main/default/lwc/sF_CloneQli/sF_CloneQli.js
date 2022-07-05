import { LightningElement, track, wire } from 'lwc';
import cloneQli from '@salesforce/apex/SF_CloneQli.cloneQli';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CurrentPageReference, NavigationMixin } from 'lightning/navigation';

export default class SF_CloneQli extends NavigationMixin(LightningElement) {
    @track clones;
    @track error;
    quoteId;
    currentQuoteId;

    //@description: Gets current page Id.
    @wire(CurrentPageReference)
    getCurrentPageReference(currentPageReference) {
        if (currentPageReference) {
            this.currentQuoteId = currentPageReference.state.recordId;
        }
    }

    //@description: call apex method and redirect created clone page.
    connectedCallback() {
        if (this.currentQuoteId !== null || this.currentQuoteId !== '' || this.currentQuoteId !== undefined) {
            cloneQli({ quoteId: this.currentQuoteId })
                .then(result => {
                    this.clones = result;
                    //const clonedQuoteId = this.clones[0].Id;
                   //this.navigateToEdit(clonedQuoteId);
                    this.error = undefined;
                })
                .catch(error => {
                    this.error = error;
                    this.clones = undefined;
                });
        }
        this.showToast();
    }

    //@description: show message when added succesfuly.
    showToast() {
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'Quote add succesfully',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    //@description: navigate newly created clone .
    navigateToEdit(event) {
            console.log(event.target.value)
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.value,
                objectApiName: 'Quote__c',
                actionName: 'view'
            },
        });
        if (myWindows.length > 0)
        myWindows.pop().close();
    }
}