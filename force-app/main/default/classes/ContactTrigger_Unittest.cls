@isTest
public class ContactTrigger_Unittest {
	/* 1st Way */
    
    public static testMethod void verifyPhonePositiveTest(){
        /*
         * Insert Test Data
         * 
         */ 
        Test.startTest();
        	
        Test.stopTest();
    }
    /* 2nd Way *
     */
    @isTest static void verifyPhoneNegativeTest(){
        Test.startTest();
        	
        Test.stopTest();
    }
}