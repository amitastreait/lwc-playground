trigger LocationTrigger on Location__c (after insert) {

    if(Trigger.isAfter && Trigger.isInsert ){
        for( Location__c loc : Trigger.New ){
            LocationTriggerHandler.verifyAddress(loc.Id); 
        }
    }
    
}