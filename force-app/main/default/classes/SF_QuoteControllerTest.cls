/*
* ============================================
* @apexTestClassName: SF_CreateQuoteTestController.cls
* @description: Test class for SF_QuoteController.cls 
* @author: Ana Tsirekidze
* @email: acirek111dze@gmail.com
* @dateCreated: 15/05/2022
* @lastChange: 16/05/2022 by Ana C.
* ============================================
*/
@isTest(SeeAllData=true)
private class SF_QuoteControllerTest {

        //static test method void testcreateQuote()
        @isTest
        static void testcreateQuote(){

            List<Opportunity> opp=[SELECT Id FROM Opportunity WHERE Account.Name=:'Ann' LIMIT 1];
            Quote__c quote=SF_QuoteController.createQuote(opp[0].Id);
            Quote__c quotes=[SELECT Id FROM Quote__c LIMIT 1];
            List<Quote_Line_Item__c> qli = [SELECT Id, Name FROM Quote_Line_Item__c WHERE Quote__c =:quotes.Id];
 
         //   System.assert(qli[0].Servie_Date__c==System.today());
            System.assert(quotes!=null);
            System.assert(qli!=null);

        }

}