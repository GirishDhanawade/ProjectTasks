//We have to retrieve Account object for perticular ID throught http callouts
//Make one class whose name is AccountObjectCallouts
public class AccountObjectCallouts
{
    //make one static get method makeGetCallout
    public static HttpResponse makeGetCallout() 
    {
        Http http = new Http();
        //Creating request instance of HttpRequest Class
        HttpRequest request = new HttpRequest();
        //We have to set first Endpoints and methods
        request.setEndpoint('https://enzigmasoftwareprivatelim-b-dev-ed.develop.my.salesforce.com/services/apexrest/Accounts');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) 
        {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'Accounts' key as a list
            List<Object> accounts = (List<Object>) results.get('accounts');
            System.debug('Received the following accounts:');
            for(Object account: accounts) 
            {
                System.debug(account);
            }
        }
       // System.debug(response);
        return response;
        
    }   
}