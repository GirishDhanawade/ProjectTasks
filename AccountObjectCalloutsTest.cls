//write test class for AccountObjectCallouts class
@isTest
    // We have to define a mock class that implements the HttpCalloutMock interface
    private class AccountObjectCalloutsTest  implements HttpCalloutMock
    {
        // Implement the mock response for the HTTP callout
        // write method to handle http request
        public HttpResponse respond(HttpRequest request) 
        {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            //Write required parameters like SetHeader and Body
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"accounts": [{"Name": "Test Account 1"},{"Name": "Test Account 2"}]}');
            response.setStatusCode(200);
            return response;
        }
    @isTest
    static void testMakeGetCallout() 
    {
        // Set up the test data
        // we have to define static method of test class
        Test.setMock(HttpCalloutMock.class, new AccountObjectCalloutsTest());
        //returns reference of the class object for HttpCalloutMock class 
        // Call the method that makes the HTTP callout
        HttpResponse response = AccountObjectCallouts.makeGetCallout();
        // Verify the response
        System.assertEquals(200, response.getStatusCode());
        System.assert(JSON.deserializeUntyped(response.getBody()) instanceof Map<String, Object> , 'Json object is not properly converted into SObject');
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> accounts = (List<Object>) results.get('accounts');
        //we add two records and checking for that
        System.assertEquals(2, accounts.size());
        //Checking for created account
        System.assertEquals('Test Account 1', ((Map<String, Object>)accounts[0]).get('Name'));
        System.assertEquals('Test Account 2', ((Map<String, Object>)accounts[1]).get('Name'));
    }
}