/*
* ============================================
* @apexClassName: SF_MakePrimaryHelper.cls
* @description: Make one primary
* @author: E.Kandelaki
* @testClass: SF_MakePrimaryHelperTest.cls
* @dateCreated: 17/06/2022
* @lastChange: 23/06/2022 by E.Kandelaki
* ============================================
*/



public with sharing class SF_MakePrimaryHelper {

    public static  Boolean firstCall = true;
    public static void deleteQuote(List<Quote__c> newQuoteList,List<Quote__c> oldQuoteList){
   

        for (Quote__c a : oldQuoteList) {
            if (a.Primary__c == true) {
            a.addError(System.Label.DeleteMessage);
            } 
}
    
}
    
    public static void insertQuote(List<Quote__c> newQuoteList){
            
            Integer numberOfQuotes = [Select Count() From Quote__c where Opportunity__c=:newQuoteList[0].Opportunity__c LIMIT 1];
             
            if(numberOfQuotes == 0){
                newQuoteList[0].Primary__c = true;
            }
        
    }
    public static void updateQuote(List<Quote__c> newQuoteList){
            List<Quote__c> quotes = [Select id,Name,Primary__c From Quote__c where Opportunity__c=:newQuoteList[0].Opportunity__c AND Primary__c=true AND Id Not In:newQuoteList ];
            if(quotes.size() > 0){
                List<Quote__c> quotesToUpdate = new List<Quote__c>();
                for(Quote__c a: quotes){
                    if(a.Id != newQuoteList[0].Id && a.Primary__c == true){
                        Quote__c q = new Quote__c();
                        q.Id = a.Id;
                        q.Primary__c = false;
                        quotesToUpdate.add(q);
                    }
                }
                update quotesToUpdate;  
            }
        }
    public static void unCheckQuote(List<Quote__c> newQuoteList,List<Quote__c> oldQuoteList){
        for(Quote__c a : oldQuoteList){

            for (Quote__c b : newQuoteList) {
            if (a.Primary__c == true && b.Primary__c == false && a.Id==b.Id) {
            b.addError(System.Label.Unchecked);
            } 
    }
        
    }
}


}   
    /*
public static void triggers(List <Quote__c> newInsert,List <Quote__c> newOld) {

//Error message if delete quote with Primary__c == true
if (Trigger.isDelete) {
for (Quote__c a : newOld) {
if (a.Primary__c == true) {
a.addError(System.Label.DeleteMessage);
} 
}
return;
}

List<Quote__c> opp=[Select id,Name From Quote__c where Opportunity__c=:newInsert[0].Opportunity__c LIMIT 1];

//create first quote with Primary__c == true
Boolean makePrimary=true;
if (Trigger.isInsert){
if(opp.size()==0){
newInsert[0].Primary__c=true;
}
}


//update existing quote with Primary__c == true
if (Trigger.isUpdate){
if(quoteToChange){
quoteToChange = true;
Boolean first;
Quote__c quoteToChange;
if(opp.size()>0){
List<Quote__c> quote=[Select id,Name,Primary__c From Quote__c where Opportunity__c=:newInsert[0].Opportunity__c AND Primary__c=true];

for(Quote__c a: quote){
if(a.Id!=newInsert[0].Id && a.Primary__c==true){
a.Primary__c=false;  
update a;
}
}  

}
}
}

//error message when unchecked quote with Primary__c == true

if (Trigger.isUpdate){
for(Quote__c a : newOld){

for (Quote__c b : newInsert) {
if (a.Primary__c == true && b.Primary__c == false && a.Id==b.Id) {
b.addError(System.Label.Unchecked);
} 
}

}
}
}*/