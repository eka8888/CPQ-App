trigger SF_QLITrigger on Quote_Line_Item__c (before insert) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        SF_QLITriggerHelper.settingValues(Trigger.new);
    }
}