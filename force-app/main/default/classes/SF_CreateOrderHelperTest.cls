@isTest
public class SF_CreateOrderHelperTest {
    @TestSetup
    static void testData(){
        Account testacc=new Account(Name='TestAccount');
        insert testacc;
        
        Opportunity testOpp=new Opportunity(Name='opp',StageName='Prospecting',CloseDate=System.today().addDays(7));
        insert testOpp;
        
        Quote__c newQuote = new Quote__c(Account__c=testacc.Id,Name='test',Opportunity__c=testOpp.Id, Status__c='Draft');
        insert newQuote;
        
        Quote_Line_Item__c qli = new Quote_Line_Item__c(quote__c=newQuote.Id,Name='testqli');
        insert qli;
        
    }
    @isTest 
    static void createOrderTest(){
        
        Account acc=[Select Id FROM Account Where Name='TestAccount'];
        Opportunity opp=[Select Id FROM Opportunity Where Name='opp'];
     

        List<Quote__c> quoteTest=[SELECT Id,Status__c,Account__c,Name,Opportunity__c  FROM Quote__c Where Status__c='Draft' ];
       // Test.startTest();
        for(Quote__c q: quoteTest) {
            q.Status__c = 'Accepted';
              q.Account__c = acc.Id;
       
        q.Primary__c=true;
        q.Expiration_Date__c=system.TODAY();
        q.Shipping_Adress__c='Tbilisi';
        q.Billing_Address__c='tbilisi';
        q.Billing_Country__c='georgia';
        q.Billing_Postal_Code__c=236;
        q.Billing_State__c='tbilisii';
        q.Billing_Street__c='chachavadze';
        q.Shipping_State__c='tbilisi';
        q.Shipping_Street__c='rustaveli';
        q.Shipping_Country__c='Georgia';
        q.Shipping_Postal_Code__c=156;
        q.Status__c='Accepted';
   
        }
        update quoteTest;
    
        //Test.stopTest();
        
        //List<Order__c> orders = [SELECT Id FROM Order__c Where Account__c =:quoteTest.Account__c];
        List<Order__c> orders = [SELECT Id FROM Order__c];
        System.assert(orders.isEmpty(),'List should not be empty');
        
        
    }
}