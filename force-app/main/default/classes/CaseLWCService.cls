/**
 * @File Name          : CaseLWCService.cls
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 23/6/2020, 1:54:34 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    23/6/2020   Amit Singh     Initial Version
**/
public with sharing class CaseLWCService {
    public CaseLWCService() {

    }

    @AuraEnabled
    public static List<Case> fetchCases(){
        return [SELECT Id, CaseNumber, Subject, Description, AccountId, Account.Name, ContactId,
        Contact.Name, Status, Priority 
        FROM CASE
        LIMIT 10];
    }
}

