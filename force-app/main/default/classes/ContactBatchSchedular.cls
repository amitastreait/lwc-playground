public class ContactBatchSchedular implements System.Schedulable{
    
    public void execute(System.SchedulableContext SC){
        ContactBatch batch = new ContactBatch();
        Final Integer BATCH_SIZE = 10;
        Database.executeBatch(batch, BATCH_SIZE);
        /*CronTrigger ct = [SELECT Id, CronJobDetailId, NextFireTime, 
                          		 PreviousFireTime, State, StartTime, 
                                 EndTime, CronExpression, TimeZoneSidKey, 
                          OwnerId, LastModifiedById, CreatedById, 
                          CreatedDate, TimesTriggered 
                          FROM CronTrigger
                          Where Id =: SC.getTriggerId()
                         ];*/
        //System.debug(' '+ct);
    }
}