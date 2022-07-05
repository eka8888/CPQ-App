import { LightningElement, wire, api } from 'lwc';
import { CurrentPageReference} from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import createQuote from '@salesforce/apex/SF_QuoteController.createQuote';

export default class SF_CreateQuote extends NavigationMixin (LightningElement) {
    recordId;
    quoteId;
    @api isLoaded=false;


    //@author: Ana Tsirekidze
    //@param  CurrentPageReference: current opportunity pages url
    //@description: sends recordId to apex method and gets quote data.
    @wire(CurrentPageReference)
    getCurrentPageReference(currentPageReference) {
        if(currentPageReference) {
          this.recordId = currentPageReference.state.recordId;   
        }
        console.log(this.recordId);
        if(this.recordId != null){
            createQuote({oppId:this.recordId}).then(result =>{
            this.isLoaded=true;
            this.navigateToQuoteEditPage(result.Id);
            }).catch(error=>{
                console.log(error);
            });  
        }
    }
    
    //@author: Ana Tsirekidze
    //@param  quoteId: created quotes Id.
    //@description: redirects to quote edit page.
    navigateToQuoteEditPage(quoteId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: quoteId,
                objectApiName: 'Quote__c',
                actionName: 'edit'
            },
        });
    }






}