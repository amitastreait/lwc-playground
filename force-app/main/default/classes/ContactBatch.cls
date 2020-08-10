/**
 * @File Name          : ContactBatch.cls
 * @Description        : 
 * @Author             : A Singh
 * @Group              : 
 * @Last Modified By   : A Singh
 * @Last Modified On   : 6/3/2020, 11:30:25 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    6/3/2020   A Singh     Initial Version
**/
global class ContactBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    global Integer total_size   = 0;
    global Integer fail_size    = 0;
    global Integer success_size = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug(System.LoggingLevel.DEBUG, 'Demo Changes');
        String Query = 'Select Id, Name, Fax, Email, MobilePhone, Description, Account.Name, '+
            'Account.Rating, Account.Phone,Account.Fax, Account.Industry From Contact Where AccountId != null';
        
        return Database.getQueryLocator(Query);
    }
    global void execute(Database.BatchableContext bc, List<Contact> contactList){
        
        AsyncApexJob[] apexJobs = [Select Id, 
                                          ApexClassId, ApexClass.Name, 
                                   		  NumberOfErrors, JobItemsProcessed,  
                                          TotalJobItems, Status,
                                   	      JobType	
                                   From AsyncApexJob 
                                   Where Id =:bc.getJobId()
                                  ];
		
        AsyncApexJob[] apexJobs_child = [Select Id, 
                                          ApexClassId, ApexClass.Name, 
                                   		  NumberOfErrors, JobItemsProcessed,  
                                          TotalJobItems, Status,
                                   	      JobType	
                                   From AsyncApexJob 
                                   Where Id =:bc.getChildJobId()
                                  ];
		
        Integer size = contactList.size();
        total_size = total_size + size;
        
        For(Integer i=0; i< size; i++){
            Contact con = contactList.get(i);
            if(con.Fax == null || con.Fax == '') {
                con.Fax = con.Account.Fax;
            }
            if( con.MobilePhone == null || con.MobilePhone == '') {
                con.MobilePhone = con.Account.Phone;
            }
            con.Email = 'sfdcdemo_sfdc12@outlook.com';
            con.Description = con.Account.Name+' '+con.Account.Rating +' '+con.Account.Industry+' '+con.Email;
        }
        
        Database.SaveResult[] result =  Database.update(contactList, false); 
        Integer size_result = result.size();
        For(Integer i=0; i< size_result; i++){
            Database.SaveResult sr = result.get(i);
            if(sr.isSuccess()){
                success_size += 1;
            }else{
               fail_size += 1; 
            }
        }
    }
    
    global void finish(Database.BatchableContext bc){
        
        AsyncApexJob[] apexJobs = [Select Id, 
                                          ApexClassId, ApexClass.Name, 
                                   		  NumberOfErrors, JobItemsProcessed,  
                                          TotalJobItems, Status,
                                   	      JobType	
                                   From AsyncApexJob 
                                   Where Id =:bc.getJobId()
                                  ];
		
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Status of Batch Class : ContactBatch');
        email.setSenderDisplayName('SFDC Panther Demo');
        email.setHtmlBody('Dear User, <br/> Batch processed'+
                         '<br/> Total Records : '+total_size+
                         ' <br/> Success Count : '+success_size+
                         ' <br/> Fail Count '+fail_size);
        List<String> emailTo =  new List<String>();
        emailTo.add('sfdcpanther@gmail.com');
        email.setToAddresses(emailTo);
        
        Messaging.SingleEmailMessage[] emailList = new List<Messaging.SingleEmailMessage>();
        emailList.add(email); 
        
        Messaging.sendEmail(emailList, false);
        
    }
}