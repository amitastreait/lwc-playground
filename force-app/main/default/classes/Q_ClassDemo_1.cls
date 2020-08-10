public class Q_ClassDemo_1 implements System.Queueable {
    public Id parentId;
    public Q_ClassDemo_1(Id accountId){
        this.parentId = accountId;
    }
    public void execute(QueueableContext content){
        Contact con = new Contact(LastName='Contact', FirstName='Queueable', AccountId=this.parentId);
        insert con;
        Q_ClassDemo_2 qClass2 = new Q_ClassDemo_2(this.parentId);
        if( !test.isRunningTest())
        	Id batchId2 = System.enqueueJob(qClass2);
    }
}