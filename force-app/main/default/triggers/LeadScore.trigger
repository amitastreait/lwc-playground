trigger LeadScore on Lead (after insert) {
    List<Id> upsertedLeadIds = new List<Id>();
    for(Lead upsertedLead: Trigger.New){
        upsertedLeadIds.add(upsertedLead.Id);
    }
    
    LeadScoreGenerator.createScoreAndFactors(upsertedLeadIds);
}