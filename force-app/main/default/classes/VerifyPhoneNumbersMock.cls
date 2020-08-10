@IsTest
public class VerifyPhoneNumbersMock implements HttpCalloutMock {
	
    public HttpResponse respond( HttpRequest request ) {
        HttpResponse response = new HttpResponse();
        String jsonBody = '{'+
                      '"valid": true,'+
                      '"number": "14158586273",'+
                      '"local_format": "4158586273",'+
                      '"international_format": "+14158586273",'+
                     '"country_prefix": "+1",'+
                      '"country_code": "US",'+
                      '"country_name": "United States of America",'+
                      '"location": "Novato",'+
                      '"carrier": "AT&T Mobility LLC",'+
                      '"line_type": "mobile"'+
                    '}';
        response.setBody(jsonBody);
        response.setStatusCode(200);
        return response;
    }
}