public  class SF_QliWrapper {
    public String name {get;set;}
    public Decimal unitPrice { get; set; }
    public Decimal totalPrice { get; set; }
    public Decimal subTotal { get; set; }
    public Decimal discount { get; set; }
    public Decimal quantity{get;set;}
    public List<Product2> related{get;set;}

    public SF_QliWrapper(List<Product2> relatedToQLI,Quote_Line_Item__c item){
       if(item!=null){
        this.name=item.Name;
        this.unitPrice=item.Unit_Price__c;
      //  this.subTotal=item.SubTotal__c;
        this.quantity=item.Quantity__c;
        this.related=relatedToQLI;
           }
    }
}