/*
    Name        : VerifyPhoneNumbers
    Author Name : Amit Singh
    Create Date : June 14, 2019
    Version No  : Initial version Created
    Description : Class is responsible for Validating the phone no.
    
    **************************************** Modified History ******************************************************
    **SR.No******* Modified By *********** Modified Date ************* Version No ********* Description       ******
    ****************************************************************************************************************
    
    **  01 ******* Amit Singh  *********** June 14, 2019  ************* V 1.0    *********** Initial version Created* 
 
    ****************************************************************************************************************
*/
public with sharing class VerifyPhoneNumbers {
    
    /*Contact con = [Select Id, Name, Phone From Contact LIMIT 1];
      VerifyPhoneNumbers.sobjectAsParam(JSON.serialize(con));
	*/
    
	@Future(callout=true)
    public static void doFuture(Id recordId){
        Contact con = [Select Id, Name, Phone From Contact Where Id =: recordId];
        vefiryNum(con, 'Phone');
    }
    
    /*
     * Yes. 
     * 1 - JSON.serialize(); => String (From where you are calling future method)
     * 2 - inside future method = > JSON.deserialize(String sObjectData);
     */ 
    @Future(callout=true)
    public static void sobjectAsParam(String sObjectData){
        Contact con = (Contact)JSON.deserialize(sObjectData, Contact.class);
        vefiryNum(con, 'Phone');
    }
    
    public static String vefiryNum(sObject sobj, String PhoneField){
        String endPointURL = System.Label.VerifyNumUrl + System.Label.VerifyNum;
        String phoneNo = (String)sobj.get(phoneField);
        phoneNo = '1'+phoneNo;
        
        endPointURL += '&number='+phoneNo+'&country_code=&format=1';
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        httpReq.setEndpoint(endPointURL);
        httpReq.setHeader('Content-Type', 'application/json');
        Http http = new http();
        HttpResponse httpRes = new HttpResponse();
        String response = 'No Response';
        try{
           httpRes = http.send(httpReq); 
            if(httpRes.getStatusCode() == 200){
                response = httpRes.getBody();
            }else{
                response = httpRes.getBody();
            }
            System.debug(' Response From API . '+response);
            return response;
        }catch(System.CalloutException ex){
            System.debug(' #### '+ex.getStackTraceString());
        }
        return null;
    }
}