public class Util {
    @future 
    public static void insertUserWithRole(
        String uname, String al, String em, String lname) {

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT Id FROM UserRole WHERE Name='COO'];
        // Create new user with a non-null user role ID 
        User u = new User(alias = al, email=em, 
            emailencodingkey='UTF-8', lastname=lname, 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
            timezonesidkey='America/Los_Angeles', 
            username=uname);
        insert u;
    }
    public static void insertUserWithNoRole(
        String uname, String al, String em, String lname) {
        Profile p = [SELECT Id FROM Profile WHERE Name='Chatter Free User' Limit 1];
        User u = new User(alias = al, email=em, 
            emailencodingkey='UTF-8', lastname=lname, 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id,
            timezonesidkey='America/Los_Angeles', 
            username=uname);
        insert u;
    }
}