/*
* ============================================
* @apexClassName: CloneQuote.cls
* @description: create clone quote and quote line item 
* @author: E.Kandelaki
* @testClass: SF_CloneQuoteTest
* @dateCreated: 09/06/2022
* @lastChange: 13/06/2022 by E.Kandelaki
* ============================================
*/

public with sharing class SF_CloneQuote {
    @AuraEnabled
    //@description: Gets custom metadatatype fields.
    public static List<Quote__c>  cloneQuote(Id quoteId) {
        Clone_Quote_Fields_Mapping__mdt[] cloneFields = [SELECT Fields__c, QualifiedApiName  FROM Clone_Quote_Fields_Mapping__mdt]; 
        //for quotes
        Set<String> quoteFieldss = new Set<String>();
        String quoteFields;

       //get and sort quote and qli from customemmetadatatype
        for(Clone_Quote_Fields_Mapping__mdt quoteF: cloneFields){      
            if(quoteF.QualifiedApiName == 'Quote_fields'){
                quoteFieldss.addAll(quoteF.Fields__c.split(','));
                System.debug(quoteFieldss);
            }
        }
        
        String quote = String.join(new List<String>(QuoteFieldss), ', ');
         
        //create clone quote and put fields and value
        Quote__c newQuote = new Quote__c();
        Quote_Line_Item__c newQli = new Quote_Line_Item__c();

        Quote__c oldQuote=Database.query('Select ' + quote + ' From Quote__c WHERE Id=:quoteId LIMIT 1' ); 

         for(String field:quoteFieldss){
             newQuote.put(field,oldQuote.get(field));
         }
         insert newQuote;
        
         return new List<Quote__c> {newQuote};
        
}
}