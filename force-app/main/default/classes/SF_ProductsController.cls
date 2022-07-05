/*
* ============================================
* @apexClassName: SF_CreateQuoteController.cls
* @description: apex class which contains logic to work with quote custome object.
* @author: Ana Tsirekidze
* @email: acirek111dze@gmail.com
* @testClass: 
* @dateCreated: 29/03/2022
* @lastChange: 30/03/2022 by Ana C.
* ============================================
*/
public with sharing class SF_ProductsController {
    /**
* @author: Ana Tsirekidze
* @param  oopId. We pass here current opportunity Id, from Url parameter
* @description: Apex method that creates quote under current opportunity.
*/
@AuraEnabled(cacheable=true)
public static String getFieldsLabels(){

    List<FieldsConfig__mdt> fieldsConfig= [ SELECT Id,  Configure_Product_Fields__c 
                                            FROM FieldsConfig__mdt 
                                            WHERE Label = 'Configure Product Fields' LIMIT 1];


    Set<String> fields = new Set<String>();
    

    for(FieldsConfig__mdt item : fieldsConfig){
        fields.addAll(item.Configure_Product_Fields__c.split(','));
    }

    String dataFields = String.join(new List<String>(fields),',');

    return dataFields;
}


    /**
* @author: Ana Tsirekidze
* @param  oopId. We pass here current opportunity Id, from Url parameter
* @description: Apex method that creates quote under current opportunity.
*/
@AuraEnabled
public static List<Quote_Line_Item__c> QlisList(Id qId) {


    List<Quote_Line_Item__c> qlis = [SELECT Id, Name__c, List_Price__c, 	Quantity__c, 	Subtotal__c, 	Unit_Price__c, (
                                    SELECT Id, Name, List_Price__c, 	Quantity__c, 	Subtotal__c, 	Unit_Price__c 
                                    FROM 	Quote_Line_Items__r) 
                                    FROM Quote_Line_Item__c 
                                    WHERE Is_Bundle__c=:true];

   List<Quote_Line_Item__c> bundles = [SELECT Id, Name__c, List_Price__c, Quantity__c, Subtotal__c, Unit_Price__c, Is_Bundle__c, Quote_Line_Item__c
                                    FROM Quote_Line_Item__c 
                                    WHERE Quote__c =:qId
                                    AND Is_Bundle__c=:true];  
                                    
    List<Quote_Line_Item__c> options = [SELECT Id, Name__c, List_Price__c, Quantity__c, Subtotal__c, Unit_Price__c, Is_Bundle__c, Quote_Line_Item__c, 
    (SELECT Id, Name FROM Quote_Line_Items__r)
                                    FROM Quote_Line_Item__c 
                                    WHERE Quote__c =:qId
                                    AND 	Optional__c=:true];                                   
                                    
    Map<Id, List<Quote_Line_Item__c>> quoteLineItems = new Map<Id, List<Quote_Line_Item__c>>();
    List<Quote_Line_Item__c> bundle = new List<Quote_Line_Item__c>();
    


    for(Quote_Line_Item__c optional : options){
        if(quoteLineItems.containsKey(optional.Quote_Line_Item__c)){
            List<Quote_Line_Item__c> option =quoteLineItems.get(optional.Quote_Line_Item__c) ;
            option.add(optional);
            quoteLineItems.put(optional.Quote_Line_Item__c,option);
        }else{
            List<Quote_Line_Item__c> option = new List<Quote_Line_Item__c>();
            option.add(optional);
            quoteLineItems.put(optional.Quote_Line_Item__c, option);  
        }
        
    }


    


    
  /*  String fields = getFieldsLabels();
    String query='SELECT Product__c,' +fields + ' FROM  Quote_Line_Item__c WHERE Quote__c = :qId';
    List<Quote_Line_Item__c> quoteLineItems =Database.query(query);
    System.debug('ProductList: ' + quoteLineItems);

    Map<Id,Quote_Line_Item__c> mapedQli = new  Map<Id,Quote_Line_Item__c>();

    for (Quote_Line_Item__c item : quoteLineItems) {
        mapedQli.put(item.Product__c,item);
    }
    List<Product2> products = [SELECT Id, Name, Is_Bundle__c, (SELECT Id, Name FROM Products__r ) FROM Product2 WHERE Id IN :mapedQli.keySet() ];
    
    List<Product2> bundleProducts = new List<Product2>();
    for(Product2 prod : products){
        if(prod.Is_Bundle__c==true){
            bundleProducts.add(prod);
        }
    }

    List<SF_QliWrapper> qliWrapper = new List<SF_QliWrapper>();
    for(Product2 item : products){
        qliWrapper.add( new SF_QliWrapper(item.Products__r,mapedQli.get(item.Id)));
    }
    
    System.debug('Products array:' + bundleProducts);

    System.debug('wrapper'+qliWrapper);

    return bundleProducts; */

    return qlis;

}

}