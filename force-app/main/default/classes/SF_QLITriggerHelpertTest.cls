@isTest
public with sharing class SF_QLITriggerHelpertTest {
    @TestSetup 
    static void dataSetup(){

        Account acc=new Account (Name= 'Account For Test');
        insert acc;

        Contact contact = new Contact (Primary__c=true, LastName='last name', AccountId=acc.Id);
        insert contact;

        Opportunity opp=new Opportunity (Name= 'opp test', AccountId=acc.Id, CloseDate=System.today(), 	StageName='Prospecting');
        insert opp;

        Quote__c quote = new Quote__c (Name= 'test quote', 	Opportunity__c=opp.Id);
        insert quote;

        Price_List__c pl = new Price_List__c (Name__c='USD Price List');
        insert pl;

        Product2 product = new Product2 ( 	Name='RAM', 	Description__c='RAM'  );
        insert product;

        Price_List_Item__c pli = new Price_List_Item__c (Product__c=product.Id, Price_List__c=pl.Id);
        insert pli;

        Quote_Line_Item__c qli= new Quote_Line_Item__c(Name= quote.Name, Quote__c=quote.Id, SF_Price_List_Item__c=pli.Id );
        insert qli;



    }

    @isTest
    static  void testSettingValues() {


        List<Quote_Line_Item__c> qli=[SELECT Id, Name FROM Quote_Line_Item__c];
        SF_QLITriggerHelper.settingValues(qli);


    }
}