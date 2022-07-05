@isTest
public with sharing class SF_MakePrimaryHelperTest {
    
    @TestSetup
    static void testData(){
        Account acc=new Account(Name='TestAccount');
        insert acc;
        
        Contact contact = new Contact (Primary__c=true, LastName='last name', AccountId=acc.Id);
        insert contact;

        Opportunity testOpp=new Opportunity(Name='opp',StageName='Prospecting',CloseDate=System.today().addDays(7));
        insert testOpp;

        Quote__c newQuote = new Quote__c(Account__c=acc.Id,Name='test',Opportunity__c=testOpp.Id, 	Primary__c=true);
        insert newQuote; 

        Quote__c newQuote1 = new Quote__c(Account__c=acc.Id,Name='test1',Opportunity__c=testOpp.Id,Primary__c=false);
        insert newQuote1; 
    }

    @isTest 
    static void primaryTest(){
       
        Quote__c quote2= [SELECT Id,Name,Opportunity__c, Primary__c FROM Quote__c Where Primary__c=false];
        quote2.Primary__c=true;
        
        update quote2;
        Quote__c quote3 = [SELECT Id, Name,Opportunity__c, Primary__c FROM Quote__c LIMIT 1];
        Quote__c quote1= [SELECT Id,Name,Opportunity__c, Primary__c FROM Quote__c Where Primary__c=true LIMIT 1];
        System.assertEquals(true,quote1.Primary__c);
        quote1.Primary__c=true;
        update quote1;

        Quote__c quote6 = [SELECT Id, Name,Opportunity__c, Primary__c FROM Quote__c WHERE Primary__c = false LIMIT 1];
        
        delete quote6;
    }
}