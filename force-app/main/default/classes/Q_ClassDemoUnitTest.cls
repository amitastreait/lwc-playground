@isTest
public class Q_ClassDemoUnitTest {
    public static testMethod void Q_ClassDemoTest(){
        Account acc = new Account(Name='Test Queueable Account');
        insert acc;
        Q_ClassDemo qClass = new Q_ClassDemo(acc);
        Test.startTest();
        	Id batchId1 = System.enqueueJob(qClass);
        Test.stopTest();
        AsyncApexJob  jobInfo = [SELECT Id, ApexClassId, JobType, 
                                 Status, JobItemsProcessed, 
                                 NumberOfErrors, TotalJobItems, 
                                 MethodName FROM AsyncApexJob Where Id =:batchId1];
        System.debug(' jobInfo '+jobInfo);
        
        /*List<Contact> contactList = [Select Id, Name, FirstName,LastName From Contact Where AccountId =: acc.Id];
        System.assertNotEquals(null, contactList);
        System.assertEquals(1, contactList.size(), 'More than one Contact Found!!');
        System.assertEquals('Queueable', contactList.get(0).FirstName);*/
        
        List<Account> accountList = [Select id, Name, Industry From Account Where Id =: acc.Id];
        System.assertNotEquals(null, accountList);
        System.assertEquals(1, accountList.size(), 'More than one Contact Found!!');
        System.assertEquals('Update Account', accountList.get(0).Name);
        System.assertEquals('Education', accountList.get(0).Industry);
    }
}