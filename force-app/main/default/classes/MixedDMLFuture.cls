public class MixedDMLFuture {
    public static void useFutureMethod() {
        
        Account a = new Account(Name='Acme');
        insert a;
        Util.insertUserWithRole(
            'fsjbd@sfdcpanther.ceb.com', 'AMIT', 
            'amitd@sfdcpanther.dev.com', 'SINGH');        
    }
    public static void useNoFutureMethod() {
        
        Account a = new Account(Name='Acme');
        insert a;
        Util.insertUserWithNoRole(
            'fsjbd@sfdcpanther.ceb.com', 'AMIT', 
            'amitd@sfdcpanther.dev.com', 'SINGH NO FUTURE');        
    }
}