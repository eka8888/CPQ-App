/*
* ============================================
* @apexClassName: SF_QLITriggerHelper.cls
* @description: Trigger helper class. sets default quote line item values
* @author: Ana Tsirekidze
* @email: acirek111dze@gmail.com
* @testClass: 
* @dateCreated: 29/03/2022
* @lastChange: 30/03/2022 by Ana C.
* ============================================
*/
public with sharing class SF_QLITriggerHelper  {

    /**
    * @author: Ana Tsirekidze
    * @param  qlis - This parameter takes list of quote line items which values must be setten by default
    * @description: Apex method that sets default quote item values
    */
	public static void settingValues(List<Quote_Line_Item__c> qlis) {

        for(Quote_Line_Item__c qli: qlis) {

            for ( Product2 product : [SELECT Id, Name, Description__c, Is_Bundle__c FROM Product2 WHERE Id =:qli.Product__c] ){
                
                qli.Line_Item_Description__c=product.Description__c;
                qli.Name__c = product.Name;
                qli.Quantity__c=1;
                qli.Service_Date__c=System.today();

            }

            for(Price_List_Item__c pli: [SELECT Id, Base_Price__c FROM Price_List_Item__c WHERE Id =:qli.SF_Price_List_Item__c] ){

                qli.Unit_Price__c=pli.Base_Price__c;
                qli.List_Price__c=pli.Base_Price__c;  
            }
            
        }

    }
        
}