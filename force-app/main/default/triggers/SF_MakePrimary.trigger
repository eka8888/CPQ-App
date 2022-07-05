trigger SF_MakePrimary on Quote__c (before insert,before update,before delete) {//,before delete
  /*
      if(SF_MakePrimaryHelper.quoteToChange&&Trigger.isUpdate){
        SF_MakePrimaryHelper.triggers(Trigger.new,Trigger.old);
        SF_MakePrimaryHelper.quoteToChange=false;
      } else {
        SF_MakePrimaryHelper.quoteToChange=true;
      }*/
      if(Trigger.isBefore){
        if(Trigger.isInsert){
          SF_MakePrimaryHelper.insertQuote(Trigger.new);
          //SF_MakePrimaryHelper.firstCall = true;
        }else if(Trigger.isUpdate){
          if(SF_MakePrimaryHelper.firstCall){
            SF_MakePrimaryHelper.firstCall = false;
            SF_MakePrimaryHelper.updateQuote(Trigger.new);//, Trigger.old
            SF_MakePrimaryHelper.unCheckQuote(Trigger.new,Trigger.old);
          }
           
      }else if(Trigger.isDelete){
        //SF_MakePrimaryHelper.firstCall = false;
        SF_MakePrimaryHelper.deleteQuote(Trigger.new,Trigger.old);
      }
}
}