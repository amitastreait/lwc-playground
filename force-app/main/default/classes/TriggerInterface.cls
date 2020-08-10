public interface TriggerInterface {
    
    void beforeInsert(List<sObject> newRecordsList);

    void afterInsert(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap);

    void beforeUpdate(Map<Id, sObject> newRecordsMap, Map<Id, sObject> oldRecordsMap); // values()

    void afterUpdate(Map<Id, sObject> newRecordsMap,  Map<Id, sObject> oldRecordsMap);
          
    void beforeDelete(List<sObject> oldRecordsList , Map<Id, sObject> oldRecordsMap);

    void afterDelete(Map<Id, sObject> oldRecordsMap);
    
    void afterUnDelete(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap);
    
}