public class Q_ClassDemo implements System.Queueable {
    public Account acc;
    public Q_ClassDemo(Account acc){
        this.acc = acc;
    }
    public void execute(QueueableContext content){
        /* Update the Account Name and Industry*/
        this.acc.Name = 'Update Account';
        this.acc.Industry = 'Education';
        update this.acc;
        Q_ClassDemo_1 qClass1 = new Q_ClassDemo_1(this.acc.Id);
        if( !Test.isRunningTest() ) {
            /* Chain Another Job and pass the Current Account Id */
            Id batchId1 = System.enqueueJob(qClass1);
            AsyncApexJob  jobInfo = [SELECT Id, ApexClassId, JobType, 
                                     Status, JobItemsProcessed, NumberOfErrors, TotalJobItems, 
                                     MethodName FROM AsyncApexJob Where Id =:batchId1];
            System.debug(' jobInfo '+jobInfo);
        }
    }
}