/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-25-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-05-2020   Amit Singh   Initial Version
**/
public with sharing class MyUtility {

    public static void printArray(){
        List<Integer> integerarray = new List<Integer>{12,39,13,14,40};
        sortArray(integerarray);
        system.debug(integerarray);
    }
    public static void sortArray(List<Integer> integerarray){
        integerarray.sort();
        if(integerarray.size()>4){
            integerarray = null;
        }
    }

    public static void MapTest(){
        Id queueId = '00G897545453653'; //15 digit recordId
        Map<String,String> idToMap = new Map<String,String>();
        idToMap.put('00G897545453653', 'APAC Region Group');
        System.debug(+idToMap.get(queueId));
    }

    public static void accountTest(){
        Integer loopCount = 0;
        /*  Assume that the Account Record have more than 10K Records   */
        for(List<Account> accList : [Select Id, Name From Account Limit 1000]){
            loopCount++;
            for(Account acc: accList){
                loopCount++;
            }
        }
        /* What will be the Output of the loopCount variable */
        System.debug(loopCount);
    }

    public static void counterTest(){
        Integer counter = 0;
        for(Integer i=0; i<5; i++){
            for(Integer j=0; j<5; j++){
                if(j==2){
                    continue;
                }
                counter++;
            }
            if(i==3){
                break;
            }
        }
        /* What will be the Output of the counter variable */
        System.debug(counter);
    }

    /* SOQL Test */
    public static void SOQLTest(){
        /*
            Parent Object - Invoice
            Child Object  - Invoice Line Item
            Relationship  - Master-Detail 
        */
        List<Invoice_Line_Item__c> lineItem = [Select Id, Name, OwnerId From Invoice_Line_Item__c Limit 10];

        List<Opportunity> oppList = [Select Id, Name, Owner.Custom_Field__c From Opportunity Limit 100];
        
    }

    /* SOSL Test */
    public static void SOSLTest(String objectName, List<String> fieldNames, String searchKey){
        String filds = String.join(fieldNames, ',');
        String searchKeyword = searchKey + '*';
        String returningQuery = objName+' ( Id, '+filds+')';
        String query = 'FIND :searchKeyword IN ALL FIELDS RETURNING '+returningQuery+' LIMIT 2000';
        /*
            Put your code to execute the SOSL dynamically
        */
    }
    

}
