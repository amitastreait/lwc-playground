public class SchemaObjectDescriber {

    public static String fetchUserSessionId(){
        
        String sessionId = '';
        PageReference reportPage = Page.GetSessionIdVF;
        String vfContent = reportPage.getContent().toString();
        
        // Find the position of Start_Of_Session_Id and End_Of_Session_Id
        Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
            endP = vfContent.indexOf('End_Of_Session_Id');
        sessionId = vfContent.substring(startP, endP);
        
        return sessionId;
    }
    
    public static void getAllObjects() {
        String baseURL = System.URL.getSalesforceBaseUrl().toExternalForm();
        String endPoint = baseURL+'/services/data/v47.0/tooling/sobjects';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer '+fetchUserSessionId());
        
        try{
            
            HttpResponse response = (new Http()).send(request);
            
            if(response.getStatusCode() == 200 ){
                Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                List<Object> objectList = (List<Object>)responseMap.get('sobjects');
                String objLists = JSON.serialize(objectList);
                
                List<ObjectWrapper> wrapperList = (LIST<ObjectWrapper>)JSON.deserialize(objLists, LIST<ObjectWrapper>.class);
                
                Map<String, String> objectKeyPrefixAPINameMap = new Map<String, String>();
                
                for(Integer i=0; i<wrapperList.size(); i++){
                    ObjectWrapper wrapper = wrapperList.get(i);
                    objectKeyPrefixAPINameMap.put(wrapper.name, wrapper.keyPrefix);
                }
                
                Map<String, Schema.SObjectType> allSObjectMap = Schema.getGlobalDescribe();
                
                List<String> finalObjectList = new List<String>();
                
                for(String key : allSObjectMap.keySet()){
                    if(!objectKeyPrefixAPINameMap.containsKey(key.capitalize())) {
                        finalObjectList.add(allSObjectMap.get(key).getDescribe().getName());
                    }
                }
				
                System.debug(System.LoggingLevel.DEBUG, '\n ***** finalObjectList **** \n '+finalObjectList);
				                
            } else {
                System.debug(System.LoggingLevel.DEBUG, ' \n *** Error \n '+response.getBody());
            }
            
            
        }catch(System.Exception ex){
            
            System.debug(System.LoggingLevel.DEBUG, '\n **** Exceotion Executed **** \n '+ex.getStackTraceString());
            
        }
    }
    public class ObjectWrapper {
        public String keyPrefix;
        public String name;
    }
}