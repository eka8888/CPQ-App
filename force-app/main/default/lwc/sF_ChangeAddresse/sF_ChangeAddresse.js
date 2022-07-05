import { LightningElement, wire, api} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import UpdateMessage from '@salesforce/label/c.UpdateMessage';
import ErrorMessage from '@salesforce/label/c.ErrorMessage';

import SF_Shipping_Street from '@salesforce/schema/Account.SF_Shipping_Street__c';
import SF_Shipping_State from '@salesforce/schema/Account.SF_Shipping_State__c';
import SF_Shipping_Postal_code from '@salesforce/schema/Account.SF_Shipping_Postal_Code__c';
import SF_Shipping_Country from '@salesforce/schema/Account.SF_Shipping_Country__c';
import SF_Billing_Street from '@salesforce/schema/Account.SF_Billing_Street__c';
import SF_Billing_State from '@salesforce/schema/Account.SF_Billing_State__c';
import SF_Billing_Postal_Code from '@salesforce/schema/Account.SF_Billing_Postal_Code__c';
import SF_Billing_Country from '@salesforce/schema/Account.SF_Billing_Country__c';
import SF_Billing_City from '@salesforce/schema/Account.SF_Billing_City__c';
import Id_Field from '@salesforce/schema/Account.Id';
const ADDRESSFIELDS = [
        SF_Shipping_Country,
        SF_Shipping_Street,
        SF_Shipping_State,
        SF_Shipping_Postal_code,
        SF_Billing_Street,
        SF_Billing_Country,
        SF_Billing_State,
        SF_Billing_Postal_Code,
        SF_Billing_City 
    ];

export default class SF_ChangeAddresse extends LightningElement {

    label = {
        UpdateMessage,
        ErrorMessage
    }
    @api recordId;
    account;
    city;
    street;
    country;
    province;
    postalcode;
    ShowAddressForm=false;
    Address;
    mapMarkers=[];


    @wire(getRecord, {recordId: '$recordId', fields: ADDRESSFIELDS})
    wiredRecord({data}){
        this.account = data;
    } 

    // Method helps us to edit current accounts shipping address and moves map marker with following information
    editShipping(){
        this.ShowAddressForm = true;
        this.Address = 'Shipping';
        let {
            SF_Shipping_Street__c,
            SF_Shipping_Country__c,
            SF_Shipping_State__c,
            SF_Shipping_Postal_Code__c
            
        }= this.account.fields;
        
        this.setAddressInformation(
            SF_Shipping_Street__c.value,
            SF_Shipping_Country__c.value,
            SF_Shipping_State__c.value,
            SF_Shipping_Postal_Code__c.value
            
        );
        this.setmapMarkers();
    }

    // Method helps us to edit current accounts billing address and moves map marker with following information
    editBilling(){
        this.ShowAddressForm = true;
        this.Address = 'Billing';
        let {
            SF_Billing_Street__c,
            SF_Billing_Country__c,
            SF_Billing_State__c,
            SF_Billing_Postal_Code__c,
            SF_Billing_City__c
        }= this.account.fields;

        this.setAddressInformation(
            SF_Billing_Country__c.value,
            SF_Billing_Street__c.value,
            SF_Billing_State__c.value,
            SF_Billing_Postal_Code__c.value,
            SF_Billing_City__c.value
        );
        this.setmapMarkers();
    }

    // method returns address field changes
    handleChange(e) {
        let { street,  city,  province, country, postalcode}= e.target;
        this.setAddressInformation(street,  city,  province, country, postalcode);
        this.setmapMarkers();
    }


    setAddressInformation(street,  city,  province, country, postalcode ){
        this.city=city
        this.street=street;
        this.country=country;
        this.province=province;
        this.postalcode=postalcode;
    }

    // Method which we are using to move marker on map with following information
    setmapMarkers(){

            this.mapMarkers=[
                {
                location:{
                    City:this.city,
                    Country:this.country,
                    PostalCode:this.postalcode,
                    State:this.state,
                    Street:this.street,
                }
            },
        ];

    }

    save(){
        const fields={};
        fields[Id_Field.fieldApiName] = this.recordId;
        if(!this.ShowAddressForm) return;
        if(this.Address === 'Shipping'){
            fields[SF_Shipping_Street.fieldApiName] = this.street;
            fields[SF_Shipping_Country.fieldApiName]=this.country;
            fields[SF_Shipping_State.fieldApiName] = this.province;
            fields[SF_Shipping_Postal_code.fieldApiName]=this.postalcode;
            console.log(fields);
        } else if(this.Address === 'Billing') {
            fields[SF_Billing_Street.fieldApiName] = this.street;
            fields[SF_Billing_Country.fieldApiName]=this.country;
            fields[SF_Billing_State.fieldApiName] = this.province;
            fields[SF_Billing_Postal_Code.fieldApiName]=this.postalcode;
            fields[SF_Billing_City.fieldApiName]=this.city;
        }
        const recordInput = { fields };
        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: this.label.UpdateMessage,
                    variant: 'success'
                })
            );
            return refreshApex(this.contact);
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: this.label.ErrorMessage,
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });

        this.ShowAddressForm = false;

    }
}