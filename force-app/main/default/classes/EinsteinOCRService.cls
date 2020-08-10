/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-17-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-15-2020   Amit Singh   Initial Version
**/
public class EinsteinOCRService {
    public static FINAL String  OCR_API         = 'https://api.einstein.ai/v2/vision/ocr';
    public static FINAL String  OCR_MODEL       = 'OCRModel';
    public static FINAL String  OCR_MODEL_TABEL = 'tabulatev2';
    
    public static void readBusinessCard(){
        String sample = 'https://www.sfdcpanther.com/wp-content/uploads/2020/07/BusinessCard.png';
        String result = EinsteinAPIService.imageOCR(OCR_API, sample, OCR_MODEL, false, true);
        EinsteinOCRResponse response = parseResponse(result);
    }
    
    @AuraEnabled
    public static AuraResponseWrapper readBusinessCardBase64(String sampleBusinessCard, String objectName){
        String result = EinsteinAPIService.imageOCR(OCR_API, sampleBusinessCard, OCR_MODEL, true, true);
        EinsteinOCRResponse response = parseResponse(result);
        SObject sobjectRecord = Schema.getGlobalDescribe().get(ObjectName).newSObject() ;
        for(EinsteinOCRResponse.Probabilities prob : response.probabilities){
            switch on prob.attributes.tag {
                when 'PERSON' {
                    sobjectRecord.put('LastName',prob.label);
                }
                when 'PHONE' {
                    sobjectRecord.put('Phone',prob.label);
                }
                when 'MOBILE_PHONE'{
                    sobjectRecord.put('MobilePhone',prob.label);
                }
                when 'EMAIL'{
                    sobjectRecord.put('EMAIL',prob.label);
                }
                when 'WEBSITE' {
                    if(objectName.equals('Lead')){
                        sobjectRecord.put('Website',prob.label);
                    }
                }
                when 'ADDRESS' {
                    if(objectName.equals('Contact')){
                        sobjectRecord.put('MailingStreet',prob.label);
                    }else{
                        sobjectRecord.put('Street',prob.label);
                    }
                }
                when 'ORG' {
                    if(objectName.equals('Lead')){
                        sobjectRecord.put('Company',prob.label);
                    }
                }
            }
        }
        insert sobjectRecord;
        AuraResponseWrapper wrapper = new AuraResponseWrapper();
        wrapper.response = result;
        wrapper.record = sobjectRecord;
        return wrapper;
    }
    
    public static void readTextFromImageByURL(){
        String sample = 'https://i1.wp.com/www.sfdcpanther.com/wp-content/uploads/2020/07/Day-1.png';
        String result = EinsteinAPIService.imageOCR(OCR_API, sample, OCR_MODEL, false, false);
        parseResponse(result);
    }
    
    @AuraEnabled
    public static String readTextFromImageByBase64(String sample){
        /*List<ContentDocumentLink> contentLink = [SELECT ContentDocumentId, LinkedEntityId  
                                                 FROM ContentDocumentLink where LinkedEntityId ='0010o00002KIY2SAAX'];
        if(!contentLink.isEmpty()){
            ContentVersion content = [SELECT Title,VersionData FROM 
                                      ContentVersion 
                                      where ContentDocumentId =: contentLink.get(0).ContentDocumentId 
                                      LIMIT 1];
            String sample = EncodingUtil.base64Encode(content.VersionData);
            String result = EinsteinAPIService.imageOCR(OCR_API, sample, OCR_MODEL, true, false);
            parseResponse(result);
        }*/
        String result = EinsteinAPIService.imageOCR(OCR_API, sample, OCR_MODEL, true, false);
        return result;
    }
    private static EinsteinOCRResponse parseResponse(String ressult){
        EinsteinOCRResponse response = (EinsteinOCRResponse)System.JSON.deserialize(ressult, EinsteinOCRResponse.class);
        return response;
    }

    public class AuraResponseWrapper{
        @AuraEnabled
        public string response { get; set; }
        @AuraEnabled
        public sObject record { get; set; }
    }
}