@IsTest
public class VerifyPhoneNumbersErrorMock implements HttpCalloutMock {
	
    public HttpResponse respond( HttpRequest request ) {
        HttpResponse response = new HttpResponse();
        String jsonBody = '{'+
                      '"valid": false,'+
                      '"number": "14158586273",'+
                    '}';
        response.setBody(jsonBody);
        response.setStatusCode(400);
        return response;
    }
}