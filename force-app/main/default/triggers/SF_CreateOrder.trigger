trigger SF_CreateOrder on Quote__c (after insert,after update) {
    /*
   if(Trigger.isAfter && Trigger.isUpdate){
       List<Id> recordIds = new  List<Id>();
       
       for(Quote__c q : Trigger.new){
           Quote__c status = Trigger.oldMap.get(q.Id);
           if(status.Status__c != 'Accepted' && q.Status__c == 'Accepted' ){
               recordIds.add(q.Id);
           }
       }
       
       if(!recordIds.isEmpty()){
           SF_CreateOrderHelper.createOrder(recordIds);
       }    
   } */
}