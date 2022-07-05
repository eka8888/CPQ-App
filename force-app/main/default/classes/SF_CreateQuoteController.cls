/*
* ============================================
* @apexClassName: SF_CreateQuoteController.cls
* @description: apex class which contains logic to work with quote custome object.
* @author: Ana Tsirekidze
* @email: acirek111dze@gmail.com
* @testClass: 
* @dateCreated: 29/03/2022
* @lastChange: 30/03/2022 by Ana C.
* ============================================
*/

public with sharing class SF_CreateQuoteController {

     /**
    * @author: Ana Tsirekidze
    * @param  oopId. We pass here current opportunity Id, from Url parameter
    * @description: Apex method that creates quote under current opportunity.
    */
    @AuraEnabled
    public static void acceptQuote(Id qId) {
        Quote__c quote = new Quote__c();
        quote.Id=qId;
        quote.Status__c='Accepted';
        System.debug('Date passed in: ' + qId);
        update quote;
        
    }


    /**
    * @author: Ana Tsirekidze
    * @param  oopId. We pass here current opportunity Id, from Url parameter
    * @description: Apex method that creates quote under current opportunity.
    */
    @AuraEnabled
    public static Quote__c createQuote(Id oppId) {


        List<Opportunity> opps = [SELECT Id, AccountId, Price_List__c FROM Opportunity WHERE Id=:oppId LIMIT 1];

        List<Contact> contact =[SELECT Id FROM Contact WHERE AccountId =:opps[0].AccountId AND Primary__c = true LIMIT 1];

        Quote__c newQuote = new Quote__c(
            Opportunity__c= oppId,
            Account__c=opps[0].AccountId,
            Price_List__c=opps[0].Price_List__c,
            Expiration_Date__c = System.today().addDays(7),
            Contact__c=contact[0].Id,
            Status__c='Draft'
        );
            
        insert newQuote;

        List<Account> acc = [SELECT Id, Name, Price_List__c FROM Account WHERE Id =:opps[0].AccountId];
        List<Price_List__c> priceList = [SELECT Id, Name FROM Price_List__c WHERE Id =:opps[0].Price_List__c];
        List<Quote_Line_Item__c> qlis=new List<Quote_Line_Item__c>();

        List <Create_Quote_on__mdt> createQuote = Create_Quote_on__mdt.getAll().values();
        for(Create_Quote_on__mdt cquote : createQuote){
            if(cquote.Account__c==acc[0].Name && cquote.Price_List__c==priceList[0].Name){

                List<String> products = cquote.Products__c.split(',');

                List<Product2> productList = [SELECT Id, Name, Description, (SELECT Id, Base_Price__c FROM Price_List_Items__r) 
                                                FROM Product2 WHERE Name IN :products];

      
                for(Integer i=0; i<products.size(); i++){
                    Price_List_Item__c[] pli= productList[i].Price_List_Items__r;
                    Quote_Line_Item__c qli=new Quote_Line_Item__c(
                        Name=productList[i].Name,
                        Product__c=productList[i].Id,
                        Quote__c=newQuote.Id,
                        SF_Price_List_Item__c=pli[0].Id
                    );

                    insert qli;
                }
            }
        }
        return newQuote;   
    }
}