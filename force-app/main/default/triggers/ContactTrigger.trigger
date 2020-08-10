trigger ContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after undelete, after delete) {
    
    TriggerDispatcher.run( new ContactTriggerHandler() , Trigger.OperationType );
    
}