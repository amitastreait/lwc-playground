public class JWTUtil {
    
    private Final static String CLIENT_ID = '3MVG97quAmFZJfVxm0NIj75FamHRwagYXBl8N742sqGsVpeLhPAoP6YqPGHwf7DYRlAeDaKGc5bIsXisBu84s';
    private Final static String LOGIN_URL = 'https://login.salesforce.com';
    private Final static String USER_NAME = 'amitsingh@integration.org';
    
    public static void JWTSetup(){
        String jwtHeader = '{"alg":"RS256"}';
        String jwtHeaderBase64String = EncodingUtil.base64Encode(Blob.valueof(jwtHeader));
        String exp = String.valueOf(System.currentTimeMillis() / 1000);
        String jwtClaim = '{'+
            	'"iss": "'+CLIENT_ID+'",'+ 
                '"sub": "'+USER_NAME+'",'+
                '"aud": "'+LOGIN_URL+'",'+
                '"exp": "'+exp+'"'
            +'}';
        String jwtClaimBase64String = EncodingUtil.base64Encode(Blob.valueof(jwtClaim));
        
        String jwtHeaderPlusJwtClainEncoded = jwtHeaderBase64String+'.'+jwtClaimBase64String; // what you want to sign
        
        
        String base64String = '-----BEGIN RSA PRIVATE KEY-----'+
'MIIEowIBAAKCAQEAyh5/g+ZZk4j4mCIcCGqeP6gzRVd7NACoUSRClQgGD70YC4vC'+
'YMDl/LgT1E3yNrF7FiP6ecVSBPi3/Dd9OOXDgxwmxc+0a/NK0rSkCv/sAMxA+QPJ'+
'WlF6eazB1pcui1tggRhQ4hVljuZv+OZDb0Ewz3/uGCtfMKkyuAl84KcQOX3oO2cW'+
'S2urqKGrFSbdn0/vbxnjN2l+hHpmTDreitERVIO/hbdpk9C1UxTbpc6blJgdHQ1j'+
'cb6VCKwjQht03M2OO0gI5/x4ddAZe/zFvIlR3+axnIBdmPCB+1Ss6wfHdgyuXTfW'+
'hgT58CEOp3u4kwA3OdWuiOKr0d6LwN1sH6vwyQIDAQABAoIBAQC3hoHazqq/oDu6'+
'SB6UNduDicMkT477ZS1woDAlCqgWWmke8sSI/h7XHn5C5JPuvbE6JWkmcNlM0lqd'+
'lfUKWPbycfly3GrDKqLiOExMAJ3XC6Bje+C1Ng6ztP49UAFfYJV8Iwwufac93lgF'+
'9W998f/UKiGTqK5CjSAUo+jURF4jFGbYutwiOG7gL83XUmO7L3tWzKGP3+iVgHoV'+
'J+cOIBkSgWLfbRPacz/n2TowQCh4+RSBDJZ7aXPkBHlst8rCH7WK+wNPgKvZNgI1'+
'hZIvG/KGiyLDCuEmdOKspXcEPbwvkltQe7ponLQ15lNkbIF90rI+6bAUsosHLQI0'+
'Go5nswtBAoGBAO7W5L/czrAvtFIWfM41J929eSGlICZhiNwxwYBLZsdfACACIhNB'+
'2ADOMRg5XPSjs614FXCi1/iLQ1rPHeDIUzcR1LWujxSHtS71qInoWWkmSjizLjNr'+
'v9ALQyHpwAguK4RGvnaEpGe6SaJBBiYw48O31h/5s+ABZskOmiG0KqPdAoGBANik'+
'MBBFd4z6hkgVU3C8LBFSm1WJ85z6jWRcGJLTcKjDPVubz+X5At1kNQ+zBSdtMdAn'+
'VHWfJkh1QFJC1oTglfpDRuboZV/TmOEmBKG/X7Aimxt2vpt3fA9rxkt72RUJ50co'+
'Hb+X1B4mYMUynNlSJDqT3DdorX+GXvm0bYH9yDfdAoGAeSf/oChFnPCGG4IWy5AB'+
'aiV8dgnKtk2R3IlM7GTTfV1+tb3/RR+IkFgIZY5rzhngwqWA0sN4pTcX8s/QCz/z'+
'nqLn8UXchQCWc3zggxyfhoyK6BpU3HbTNZkQ8/oclMm+/3nXkk2VDJ1eTvWHRgZU'+
'8+qkr1G+4mozlthWbbR0UO0CgYBpEPfebFJWpQmK3Azjl98nZ5C+I3FqqHj6O1AP'+
'pUv2DPos+5wQRHwHMxooywGs5WBLO0fS46SFb5gKTTAMsX8LKKWyRvMjTlPOncmR'+
'SGb33VCsOSKn84LPV82LvjzB31OzRtlmmhPdq28zNCCtpRC8+AjNNo8uUdSt9btG'+
'V/ZKYQKBgDjNX8inKn5LECGiefdBA3mYbY8KBsFoIr88lM0gSYPuTYxGW1AwF88S'+
'7ve4ci2JVpIk0y8jnvKp0re/WgC3l3FORXKNikGCx9fXZZzrkr9/7EyHxeSFW09H'+
'CzC1KXbx+/CqoLHGw9fjEjijDfnylapM1ZRtbUwcsNiZ2zCkZU+z'+
'-----END RSA PRIVATE KEY-----';
        
        //Blob privateKey = EncodingUtil.base64Decode(base64String);
        
        Blob rs256sig = Crypto.sign( 'RSA-SHA256', 
            Blob.valueOf(jwtHeaderPlusJwtClainEncoded), 
            Blob.valueOf(base64String)
        );
        String hexSignature = EncodingUtil.convertToHex(rs256sig);
        
        String finalString  = jwtHeaderPlusJwtClainEncoded+'.'+hexSignature;
        
        String encodedSignature = EncodingUtil.base64Encode(Blob.valueof(finalString));
        
        System.debug(System.LoggingLevel.DEBUG, 'assertion '+encodedSignature);
        
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('POST');
        httpReq.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = 'grant_type= urn:ietf:params:oauth:grant-type:jwt-bearer&assertion='+encodedSignature;
        httpReq.setBody(body);
        
        Http http = new Http();
        
        HttpResponse httpRes = new HttpResponse();
        
        try{
            httpRes = http.send(httpReq);
            System.debug(' ResponseBody '+httpRes.getBody());
            if( httpRes.getStatusCode() == 200 && httpRes.getStatus() =='OK'){
                
            }else{
                TransactionLogHandler.doHandleExceptionWithError( httpRes.getBody() , 'LocationTriggerHandler');
            }
        }catch(System.CalloutException ex ){
            System.debug(' Exception Executed '+ex.getStackTraceString());
            TransactionLogHandler.doHandleException(ex, 'LocationTriggerHandler');
        }
        
        //System.debug(System.LoggingLevel.DEBUG, finalString);
    }

}