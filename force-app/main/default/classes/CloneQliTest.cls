@isTest
public with sharing class CloneQliTest {
/*
        @TestSetup
        static void testData(){
            Account testacc=new Account(Name='TestAccount');
            insert testacc;
    
            Opportunity testOpp=new Opportunity(Name='opp',StageName='Prospecting',CloseDate=System.today().addDays(7));
            insert testOpp;
    
            Quote__c newQuote = new Quote__c(Account__c=testacc.Id,Name='test',Opportunity__c=testOpp.Id);
            insert newQuote;
    
            Quote_Line_Item__c qli = new Quote_Line_Item__c(quote__c=newQuote.Id,Name='testqli');
            insert qli;
            
        }
        @isTest 
        static void cloneTest1(){
            Quote__c newQuote = [SELECT Id,Name FROM Quote__c LIMIT 1];
            Integer newQli = [SELECT count() FROM Quote_Line_Item__c Where Name='testqli' LIMIT 1];
            CloneQli.cloneQli(newQuote.Id);
            String name=newQuote.Name;
            System.assert(name!=null,'dont equal null');
            System.assert(newQli > 0,'dont equal null');
            
        }*/
    
    
}