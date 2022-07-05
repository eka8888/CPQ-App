public with sharing class SF_CreateQuote {
    @AuraEnabled
    public static Quote__c createQuote(Id oppId) {

        List<Opportunity> opps = [SELECT Id, AccountId FROM Opportunity WHERE Id=:oppId LIMIT 1];

        Quote__c newQuote = new Quote__c();
        newQuote.Opportunity__c= oppId;
        newQuote.Account__c=opps[0].AccountId;
        insert newQuote;
        return newQuote;
        
    }
}