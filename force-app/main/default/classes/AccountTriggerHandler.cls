public class AccountTriggerHandler {

    public static void handleBeforeDelete(List<Account> oldAccountList, Map<Id, Account> oldAccountMap) {
    
    Set<Id> accountIdsSet = oldAccountMap.keySet();
    List<Opportunity> opportunityList = [
        								 Select Id, Name, StageName, AccountId
                                         From Opportunity 
                                         Where AccountId IN : accountIdsSet
                                         AND IsWon = true
                                        ];
    Map<Id, Opportunity> opportunitiesMap = new Map<id,Opportunity>();
        for ( Opportunity opp : opportunityList ) { 
            if ( !opportunitiesMap.containsKey(opp.AccountId) ) {
                opportunitiesMap.put(opp.AccountId, opp);
            }
        }
        
        for (Account acc : oldAccountList) { 
            if( opportunitiesMap.containsKey(acc.Id) ) {
                acc.addError('You can not delete the Account which have Closed Won Opportunities! Please Contact your admin');
            }
        }
    }
}