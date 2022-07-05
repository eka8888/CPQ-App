@isTest
public class SF_CloneQuoteTest {
    
    @TestSetup
    static void testData(){
        Account testacc=new Account(Name='TestAccount');
        insert testacc;

        Opportunity testOpp=new Opportunity(Name='opp',StageName='Prospecting',CloseDate=System.today().addDays(7));
        insert testOpp;

        Quote__c newQuote = new Quote__c(Account__c=testacc.Id,Name='test',Opportunity__c=testOpp.Id);
        insert newQuote; 
    }
    @isTest 
    static void cloneTest1(){
        Quote__c newQuote = [SELECT Id,Name FROM Quote__c LIMIT 1];
        SF_CloneQuote.CloneQuote(newQuote.Id);
        String name=newQuote.Name;
        System.assert(name!=null,'dont equal null');
    
    }


    
}