/**
 * @File Name          : AccountDetailsService.cls
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 21/6/2020, 9:32:34 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    21/6/2020   Amit Singh     Initial Version
**/
public with sharing class AccountDetailsService {
    public AccountDetailsService() {

    }

    
    @AuraEnabled(cacheable = true)
    public static List<Account> fetchAccountDetails(String recordId){
        List<Account> accountList = [SELECT Id, Name, Industry, Rating, AccountNumber, 
                                    (SELECT  Id, Name, Email, Phone From Contacts)
                                    FROM Account 
                                    WHERE Id=: recordId];
        return accountList;
    }
}
