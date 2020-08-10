trigger AccountTrigger on Account (before delete) {
    if ( Trigger.IsBefore && Trigger.isDelete ) {
        AccountTriggerHandler.handleBeforeDelete( Trigger.Old, Trigger.oldMap );
    }
}