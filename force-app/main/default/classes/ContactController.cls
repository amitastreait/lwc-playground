/**
 * @File Name          : ContactController.cls
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 24/6/2020, 4:43:40 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    24/6/2020   Amit Singh     Initial Version
**/
public with sharing class ContactController {
    public ContactController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        throw new AuraHandledException('Forced error');

        /*return [
            SELECT FirstName, LastName, Email
            FROM CONTACT
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];*/
    }
}
