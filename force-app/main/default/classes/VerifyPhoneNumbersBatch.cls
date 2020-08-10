public class VerifyPhoneNumbersBatch implements Database.Batchable<sobject>, Database.AllowsCallouts {
    public String objectName;
    public String phoneField;
    public String statusField;
    
    public VerifyPhoneNumbersBatch(String objectName, String phoneField, String statusField){
        this.objectName = objectName;
        this.phoneField = phoneField;
        this.statusField = statusField;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        String Query = 'Select Id, '+phoneField+' , '+statusField+' From '+objectName +' LIMIT 100';
        
        return Database.getQueryLocator(Query);
    }
    /*
     * Callout
     * Callout
     * Callout
     * DML
     * Correct Process
     */ 
    /*
     * Callout
     * DML
     * Callout
     * DML
     * Incorrect Process
     */ 
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        Integer size = scope.size();
        For(Integer i=0; i < size; i++){
            String recordId = (String)scope.get(i).get('Id');
            String response = VerifyPhoneNumbers.vefiryNum(scope.get(i), phoneField);
            scope.get(i).put(statusField, response);
        }
        update scope;
    }
    
    public void finish(Database.BatchableContext BC){
        
    }

}