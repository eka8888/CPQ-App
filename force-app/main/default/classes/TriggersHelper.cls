public with sharing class TriggersHelper {
    /*
    public static  Boolean quoteToChange=true;
    
    public static void triggers(List <Quote__c> newInsert,List <Quote__c> newOld) {
       
    
         if (Trigger.isDelete) {
             for (Quote__c a : newOld) {
                if (a.Primary__c == true) {
                    //a.addError('You can\'t delete this quote!');
                    a.addError(System.Label.DeleteMessage);
                } 
            }
            return;
        }

        List<Quote__c> opp=[Select id,Name From Quote__c where Opportunity__c=:newInsert[0].Opportunity__c LIMIT 1];
        for(Quote__c i:opp){
            System.debug('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq               '+i.Name);
        }  
        
        Boolean makePrimary=true;
        if (Trigger.isInsert){
            if(opp.size()==0){
                newInsert[0].Primary__c=true;
            }
        }
        if (Trigger.isUpdate){
            Boolean first;
            Quote__c quoteToChange;
             if(opp.size()!=null){
                System.debug('ddddddddddddddddddddddddddddddddddddddd '+opp.size());
                List<Quote__c> quote=[Select id,Name,Primary__c From Quote__c where Opportunity__c=:newInsert[0].Opportunity__c AND Primary__c=true];
                System.debug('ddddddddddddddddddddddddddddddddddddddd check out:  '+newInsert[0].Id);
                for(Quote__c a: quote){
               if(a.Id!=newInsert[0].Id&&a.Primary__c==true){
                a.Primary__c=false;
        update a;
        break;
        
        
               }
             
        
    }
}
}
    }*/
}