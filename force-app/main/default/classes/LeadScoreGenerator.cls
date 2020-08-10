public without sharing class LeadScoreGenerator {
    public static Boolean isDecisionMaker(String title){
        List<String> decisionMakerTitles = new List<String>{'CEO','CMO','CFO','CTO','COO','EVP','SVP','VP'};
            if(decisionMakerTitles.contains(title)){
                return true;
            } else {
                return false;
            }
    }
    
    @future(callout=true)
    public static void createScoreAndFactors(List<Id> leadIds){
        Integer referenceCounter = 0;
        DateTime dateNow = DateTime.now();
        String dateNowFormatted = dateNow.format('yyyy-MM-dd\'T\'HH:mm:ssZ');
        System.debug(dateNowFormatted);
        List<Lead> upsertedLeads = [SELECT Id,Title,AnnualRevenue,Company,LeadSource FROM Lead WHERE Id IN :leadIds];
        List<Map<String,Object>> scores = new List<Map<String,Object>>();
        List<cModelFactor> modelFactors = new List<cModelFactor>();
        List<cLeadInsight> leadInsights = new List<cLeadInsight>();
        
        for(Integer i = 0; i < upsertedLeads.size(); i++){
            Lead upsertedLead = upsertedLeads[i];
            Map<String,Object> score = new Map<String,Object>();
            Map<String,Object> attributes = new Map<String,Object>();
            attributes.put('type','ScoreIntelligence');
            attributes.put('referenceId', 'lead_'+i);
            score.put('attributes',attributes);
            score.put('BaseId', upsertedLead.Id);
            score.put('LastModifiedTimeOnRecord', dateNowFormatted);
            
            if(upsertedLead.AnnualRevenue != null &&upsertedLead.AnnualRevenue >= 150000){
                score.put('Score', Integer.valueOf(Math.ceil((Math.random() * (99 - 80)) + 80)) );
            } else if(upsertedLead.AnnualRevenue != null && upsertedLead.AnnualRevenue < 150000) {
                score.put('Score', Integer.valueOf(Math.ceil((Math.random() * (79 - 50)) + 50)) );
            } else {
                score.put('Score', Integer.valueOf(Math.ceil((Math.random() * (60 - 30)) + 30)) );
            }
            scores.add(score);
            
            if(upsertedLead.Title == null){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.Title', 'IS_NOT_SPECIFIED');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_NEG', -1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, upsertedLead.Title);
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.Title != null && isDecisionMaker(upsertedLead.Title)){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.Title', 'IS_EQUAL');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_POS', 1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, upsertedLead.Title);
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.Title != null && !isDecisionMaker(upsertedLead.Title)){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.Title', 'IS_EQUAL');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_NEG', -1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, upsertedLead.Title);
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.Company != null){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.Company', 'IS_VALID');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_POS', 1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, upsertedLead.Company);
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.AnnualRevenue != null && upsertedLead.AnnualRevenue >= 150000){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.AnnualRevenue', 'IS_EQUAL');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_POS', 1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, String.valueOf(upsertedLead.AnnualRevenue));
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.AnnualRevenue != null && upsertedLead.AnnualRevenue < 150000){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.AnnualRevenue', 'IS_EQUAL');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_NEG', -1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, String.valueOf(upsertedLead.AnnualRevenue));
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.AnnualRevenue == null){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.AnnualRevenue', 'IS_NOT_SPECIFIED');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_NEG', -1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, String.valueOf(upsertedLead.AnnualRevenue));
                leadInsights.add(leadInsight);
            }
            
            if(upsertedLead.LeadSource != null){
                String guid = generateGUID();
                cModelFactor modelFactor = new cModelFactor('mf_'+referenceCounter++, guid, 'Lead.LeadSource', 'IS_SPECIFIED');
                modelFactors.add(modelFactor);
                cLeadInsight leadInsight = new cLeadInsight('li_'+referenceCounter++, 'HIGH_POS', 1, upsertedLead.Id, guid, guid+'_'+upsertedLead.Id, dateNowFormatted, String.valueOf(upsertedLead.LeadSource));
                leadInsights.add(leadInsight);
            }
        }
        
        String sid = getSession();
        
        if(scores.size() > 0) {
            Map<String,Object> compositeRequest = new Map<String,Object>();
            compositeRequest.put('records', scores);
            System.debug(JSON.serialize(compositeRequest));
            sendRequest(sid,'/composite/tree/ScoreIntelligence','POST', JSON.serialize(compositeRequest));
        }
        if(modelFactors.size() > 0){
            Map<String,Object> compositeRequest = new Map<String,Object>();
            compositeRequest.put('records', modelFactors);
            System.debug(JSON.serialize(compositeRequest));
            sendRequest(sid,'/composite/tree/ModelFactor','POST', JSON.serialize(compositeRequest));
        }
        if(leadInsights.size() > 0){            
            Map<String,Object> compositeRequest = new Map<String,Object>();
            compositeRequest.put('records', leadInsights);
            System.debug(JSON.serialize(compositeRequest));
            sendRequest(sid,'/composite/tree/LeadInsight','POST', JSON.serialize(compositeRequest));
        }
    }
    
    public static void sendRequest(String sid, String endpoint, String method, String body){
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + sid);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v43.0' + endpoint);
        req.setMethod(method);
        if(method != 'GET'){
        	req.setBody(body);
        }
        
        HttpResponse res = (new Http()).send(req);
        System.debug(res);
        System.debug(res.getBody());
    }
    
    //Get Session Token via SOAP for Lightning
    public static String getSession(){
        User restUser = [Select Username From User Where CommunityNickname = 'bpepper' Limit 1];
        HttpRequest request = new HttpRequest();
        
        String endpoint = 'https://login.salesforce.com/services/oauth2/token';
        endpoint += '?grant_type=password';
        endpoint += '&client_id=3MVG9KsVczVNcM8zdoozgJaLPPYhYyCTdBF5O2FEjAShjwa.x7YBtZq1jm52I3mqom4QqIPMGs5Ww89tI7WDe';
        endpoint += '&client_secret=3636748017614097236';
        endpoint += '&username=' + restUser.Username;
        endpoint += '&password=U29tZVNGRENNYWdpY0ZvclJFU1Q=';
        request.setMethod('POST');
        
        request.setEndpoint(endpoint);
        HttpResponse res = (new Http()).send(request);
        
        Map<String,Object> session = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        System.debug(session.get('access_token'));
        return String.valueOf(session.get('access_token'));
    }
    
    public static String generateGUID(){
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        return guid;
    }
    
    public class cModelFactor {
        public Map<String,Object> attributes {get;set;}
        public Integer Version {get;set;} 
        public String ExternalId {get;set;}
        public String Factor1 {get;set;}
        public String SourceField1 {get;set;}
        public String Type {get;set;}
        public Double ScoreCorrelation {get;set;}
        
        public cModelFactor(String refId, String eid, String f1, String t){
            Map<String,Object> attr = new Map<String,Object>();
            attr.put('type','ModelFactor');
            attr.put('referenceId', refId);
            this.attributes = attr;
            this.Version = 1;
            this.ScoreCorrelation = 100.0;
            this.ExternalId = eid;
            this.Factor1 = f1;
            this.SourceField1 = f1;
            this.Type = t;
        }
    }
    
    public class cLeadInsight{
        public Map<String,Object> attributes {get;set;}
        public String IntensityLevel {get;set;}
        public Decimal Intensity {get;set;}
        public String ParentId {get;set;}
        public String ModelFactor {get;set;}
        public String ExternalId {get;set;}
        public String LastModifiedTimeOnRecord {get;set;}
        public String Value {get;set;}
        
        public cLeadInsight(String refId, String il, Decimal i, String pi, String mf, String eid, String lmt, String v){
            Map<String,Object> attr = new Map<String,Object>();
            attr.put('type','LeadInsight');
            attr.put('referenceId', refId);
            this.attributes = attr;
            this.IntensityLevel = il;
            this.Intensity = i;
            this.ParentId = pi;
            this.ModelFactor = mf;
            this.ExternalId = eid;
            this.LastModifiedTimeOnRecord = lmt;
            this.Value = v;
        }
    }
}