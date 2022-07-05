import { LightningElement, wire, api, track } from 'lwc';
import { CurrentPageReference} from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import acceptQuote from '@salesforce/apex/SF_CreateQuoteController.acceptQuote';
import QlisList from '@salesforce/apex/SF_ProductsController.QlisList';
import fetchDataHelper from './fetchDataHelper';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'List Price', fieldName: 'List_Price__c'},
    { label: 'Subtotal', fieldName: 'Subtotal__c' },
    { label: 'Quantity', fieldname: 'Quantity__c'},
    { label: 'Unit Price', fieldName: 'Unit_Price__c' },
];
export default class SF_ConfigureProducts extends LightningElement {

    @track data; 
    columns = columns;
    options=false;
    button='+';
    recordId;
    optionProductsArray=[];

        
    
    //@author: Ana Tsirekidze
    //@param  CurrentPageReference: current opportunity pages url
    //@description: sends recordId to apex method and gets quote data.
    @wire(CurrentPageReference)
    getCurrentPageReference(currentPageReference) {
        if(currentPageReference) {
          this.recordId = currentPageReference.state.c__recordId;   
        }
        QlisList({qId:this.recordId}).then( response => {
            console.log('response from apex method', response);
            this.optionProductsArray=response;
            this.data = response;
        }).catch(error => {console.log(error)});
        
    
    }
    



    changeQuoteStatus(){
        console.log('record id:', this.recordId);
        if(this.recordId != null){
            acceptQuote({qId:this.recordId});
        }
    }

    showOptions(event){
        if(this.options==false){
            this.options=true;
            this.button= '-'   
        }else{
            this.options=false;
            this.button= '+'   
        }


        const array1 = ['a', 'b', 'c'];
        let cartqty = `${event.target.dataset.qty}`;
        this.optionProductsArray.forEach(element => console.log(element.Id));
        
    }
}