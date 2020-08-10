@IsTest
public class ContactBatchUnitTest {
	
    @TestSetup
    public static void setupData() {
        
        Account acc = TestUtility.prepareAccount( 'SFDCPanther' );
        insert acc;
        Account acc1 = TestUtility.prepareAccount( 'SFDCPanther_New' );
        insert acc1;
        
        List<Contact> contactList = TestUtility.prepareContact( acc.Id , 'Amit' , 'Singh' ,  1000 );
        insert contactList;
    }
    
    public static testMethod void batchContactTest() {
        
        Test.startTest();
        	Id bacthId = Database.executeBatch( new ContactBatch() , 2000 );
        Test.stopTest();
    }
}