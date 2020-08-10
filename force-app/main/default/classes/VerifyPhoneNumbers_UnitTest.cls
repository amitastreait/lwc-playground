@IsTest
public class VerifyPhoneNumbers_UnitTest {

    @TestSetup
    public static void setupData() {
        Account acc = TestUtility.prepareAccount('Verify Num');
        insert acc;
        Contact con = TestUtility.prepareContact( acc.Id , 'FirstName', 'LastName', 'verifynum@gmail.com');
        insert con;
    }
    
    public static testMethod void doFutureTest() {
        Contact con = [Select Id, Name From Contact Where Email = 'verifynum@gmail.com'];
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbersMock() );
        	VerifyPhoneNumbers.doFuture( con.Id );
        Test.stopTest();
    }
    
    public static TestMethod void sobjectAsParamTest() {
        Contact con = [Select Id, Name From Contact Where Email = 'verifynum@gmail.com'];
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbersMock() );
        	VerifyPhoneNumbers.sobjectAsParam(JSON.serialize(con));
        Test.stopTest();
    }
    public static TestMethod void errorTest() {
        Contact con = [Select Id, Name From Contact Where Email = 'verifynum@gmail.com'];
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbersErrorMock() );
        	VerifyPhoneNumbers.doFuture( con.Id );
        Test.stopTest();
    }
    
    
}