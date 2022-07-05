trigger quo on Opportunity (before insert) {
     public static void makePjj() {
     List<Opportunity> opp=[Select id,Name From Opportunity where id='0068d000006BjkTAAS'];

     List<Quote__c> quote=[Select Opportunity__c From Quote__c where Opportunity__c in:opp ];

     } 
}