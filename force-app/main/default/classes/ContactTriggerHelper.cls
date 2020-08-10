public class ContactTriggerHelper {
    
    public static void checkDuplicate( List<Contact> contactList) {
        Set<String> newEmailSet = new Set<String>();
        Set<String> existingEmailSet = new Set<String>();
        for ( Contact con : contactList ) {
            if ( con.Email != null ) {
                newEmailSet.add( con.Email );
            }
        }
        List<Contact> existingContactList = [Select Id, Email From Contact 
                                             Where Email IN: newEmailSet];
        for (Contact con : existingContactList ) {
            existingEmailSet.add( con.Email );
        }
        
        for ( Contact con : contactList ) { 
            if ( existingEmailSet.contains( con.Email ) ) {
                con.Email.AddError('Duplicate Email is not Allowed ');
            } else {
                existingEmailSet.add(con.Email);
            }
        }
    }
    
    public static void updateCount(List<Contact> contactList ) {
        
        Set<Id> accountIdsSet = new Set<Id>();
        for ( Contact con : contactList ) {
            if (con.AccountId != null ){
                accountIdsSet.add(con.AccountId);
            }
        }
        Map<Id, Account> accountMap = new Map<Id, Account>();
        List<Contact> conList = [Select Id, Name, AccountId From Contact Where AccountId IN :accountIdsSet ];
        for ( Contact c : conList ) {
            if ( !accountMap.containsKey(c.AccountId) ) {
                accountMap.put(c.AccountId , new Account (Id = c.AccountId, No_Of_Contacts__c = 1 ));
            } else {
                Account tempAccount = accountMap.get(c.AccountId);
                tempAccount.No_Of_Contacts__c += 1;
                accountMap.put(c.AccountId , tempAccount );
            }
        }
        try {
            update accountMap.values();
        } catch(System.Exception ex ){
            TransactionLogHandler.doHandleException(ex, 'ContactTrigger');
        }
    }
}