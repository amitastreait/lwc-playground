/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-24-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-24-2020   Amit Singh   Initial Version
**/
public with sharing class AccountLWCService {
    public AccountLWCService() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        List<Account> accountList = [Select Id, Name FROM Account  Limit 10];
        return accountList;
    }

    @AuraEnabled
    public static List<Contact> getRelatedContact(String accountId){
        List<Contact> contactList = [Select Id, Name FROM Contact Where AccountId =:accountId Limit 10];
        return contactList;
    }
}
