@IsTest
public class AccountTriggerUnitTest {
	
    public static testMethod void accountTriggerTest() {
        Account acco = New Account(Name = 'Test AccountTrigger ');
        insert acco;
        List<Opportunity> opportunityList = new List<Opportunity>();
        for ( Integer i=0; i< 10; i++) {
            Opportunity opp = new Opportunity(
            	Name = 'Test Opportunity '+String.valueOf(i),
                CloseDate = System.today().addMonths(11),
                StageName = 'Closed Lost',
                AccountId = acco.Id
            );
            opportunityList.add(opp);
        }
        insert opportunityList;
        
        Test.startTest();
            try{
                delete acco;
            }catch ( System.Exception ex ){
                
            }
        Test.stopTest();
    }
}