/*
* ============================================
* @apexClassName: SF_CreateOrderHelper.cls
* @description: Create and Activate Order when a quote is finalized/accepted
* @author: E.Kandelaki
* @testClass: SF_CreateOrderHelperTest
* @dateCreated: 27/06/2022
* @lastChange: 29/06/2022 by E.Kandelaki
* ============================================
*/

public  class SF_CreateOrderHelper {//with sharing
    /*
   @InvocableMethod(label='Create Orders')
    //@future
    public static void createOrder(List<Id> recordIds) {//
       
        
        List<Order__c> orders = new List<Order__c>();
        List<SF_Order_Product__c > orderProduct=new List<SF_Order_Product__c >();
        
        List<Quote__c> quotes = [SELECT Id, Account__c, Contact__c, Billing_Country__c, Billing_Postal_Code__c,Opportunity__c, Billing_State__c,
                                 Shipping_Country__c, Shipping_Postal_Code__c,(SELECT Id,  Name, Quantity__c, Product__c, SF_Price_List_Item__c,  Unit_Price__c 
                                                                               FROM Quote_Line_Items__r) FROM Quote__c WHERE Id IN: recordIds];
        
        Map<Id, Order__c> ordersMap = new Map<Id, Order__c>();
        
        //create orders
        for(Quote__c q : quotes){
            
            Order__c order = new Order__c(Account__c = q.Account__c,
                                          Quote__c = q.Id,
                                          Contact__c = q.Contact__c,
                                          Billing_Country__c = q.Billing_Country__c,
                                          Billing_Postal_Code__c = q.Billing_Postal_Code__c,
                                          Activated_Date__c = system.TODAY(),
                                          Opportunity__c = q.Opportunity__c,
                                          Active__c = true,
                                          Order_Start_Date__c = system.today(),
                                          Order_End_Date__c = system.today() + 30,
                                          Billing_State__c = q.Billing_State__c,
                                          Shipping_Country__c = q.Shipping_Country__c,
                                          Shipping_Postal_Code__c = q.Shipping_Postal_Code__c);
            orders.add(order);
            
            ordersMap.put(q.Id, order);         
        }
        if(orders.size()>0){
            insert orders;
        }
        //create order products
        for(Quote__c q : quotes){
            Order__c order = ordersMap.get(q.Id);
            if(q.Quote_Line_Items__r != null && !q.Quote_Line_Items__r.isEmpty()){
                for(Quote_Line_Item__c qlitem : q.Quote_Line_Items__r){
                    SF_Order_Product__c newOrderProduct = new SF_Order_Product__c(Order__c = order.Id, 
                                                                                  Product__c = qlitem.Product__c, 
                                                                                  Quantity__c = qlitem.Quantity__c,
                                                                                  Quote_Line_Item__c = qlitem.Id,
                                                                                  Start_Date__c = order.Order_Start_Date__c,
                                                                                  End_Date__c = order.Order_End_Date__c,
                                                                                  
                                                                                  Unit_Price__c = qlitem.Unit_Price__c,
                                                                                  Status__c = 'Activated');
                    orderProduct.add(newOrderProduct);
                }
            } 
        }
        insert orderProduct;
    }*/
}