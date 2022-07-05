/*
* ============================================
* @apexClassName: CloneQli.cls
* @description: create clone quote and quote line item 
* @author: E.Kandelaki
* @testClass: CloneQliTest.cls
* @dateCreated: 09/06/2022
* @lastChange: 13/06/2022 by E.Kandelaki
* ============================================
*/


public with sharing class CloneQli {
    /*
    @AuraEnabled
    public static List<Quote__c>  cloneQli(Id quoteId) {
         //@description: Gets custom metadatatype fields.
        Clone_Quote_Fields_Mapping__mdt[] cloneFields = [SELECT Fields__c, QualifiedApiName  FROM Clone_Quote_Fields_Mapping__mdt]; 

        //for quotes
        Set<String> quoteFieldss = new Set<String>();
        String quoteFields;
        
        //for qlis
        List<String> qliFieldss = new List<String>();
        List<String> qliFields;
        //get and sort quote and qli from customemmetadatatype
        for(Clone_Quote_Fields_Mapping__mdt quoteF: cloneFields){      
            if(quoteF.QualifiedApiName == 'Quote_fields'){
                quoteFieldss.addAll(quoteF.Fields__c.split(','));
            }
            else if(quoteF.QualifiedApiName == 'Quote_Line_Item_fields'){
                qliFieldss.addAll(quoteF.Fields__c.split(','));
            }   
        }
        
        String quote = String.join(new List<String>(QuoteFieldss), ', ');
        String qli = String.join(new List<String>(QliFieldss), ', ');
         
        //create clone quote and put fields and value
        Quote__c newQuote = new Quote__c();
        Quote__c oldQuote=Database.query('Select ' + quote + ' From Quote__c WHERE Id=:quoteId LIMIT 1' ); 
        for(String field:quoteFieldss){
            newQuote.put(field,oldQuote.get(field));
        }
        insert newQuote;

        //create clone qli and put fields and value
        List<Quote_Line_Item__c> newQli = new List<Quote_Line_Item__c>();
        List <Quote_Line_Item__c> oldQli=Database.query('Select ' + qli + ' From Quote_Line_Item__c WHERE Quote__c=:quoteId Limit 20');
    
        for(Quote_Line_Item__c qliOld : oldQli) {
            Quote_Line_Item__c clonedQli = new Quote_Line_Item__c();
            clonedQli.Quote__c = newQuote.Id;
            for(String field : qliFieldss) {
                clonedQli.put(field, qliOld.get(field));
			}
            newQli.add(clonedQli);
        }
      
         insert newQli;
        System.debug(newQli);
         return new List<Quote__c> {newQuote};
        
}*/
}