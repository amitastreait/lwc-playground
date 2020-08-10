public class Q_ClassDemo_2 implements System.Queueable {
    public Id parentId;
    public Q_ClassDemo_2(Id accountId){
        this.parentId = accountId;
    }
    public void execute(QueueableContext content){
        Contact con = new Contact(LastName='Contact2', FirstName='Queueable', AccountId=this.parentId);
        insert con;
    }
}