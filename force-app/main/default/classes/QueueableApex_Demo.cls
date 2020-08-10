global class QueueableApex_Demo implements System.Queueable {
    
    global Account acc;
    
    global QueueableApex_Demo(Account acc){
        this.acc = acc;
    }
    
    global void execute(QueueableContext QC){
        /* Call the debug method which will update the name, industry and phone of account record */
        debugMethod();
        /* Again update account record Name */
        this.acc.Name = this.acc.Name+' Queueable Account';
        update this.acc;
        
        Contact con = [Select Id, Name, Phone From Contact LIMIT 1];
        VerifyPhoneNumbers.sobjectAsParam(JSON.serialize(con));
    }
    
    global void debugMethod(){
        this.acc.Name = 'Update From';
        this.acc.Industry = 'Education';
        this.acc.Phone = '7607327933';
        this.acc.Rating = 'Cold';
        update this.acc;
    }
}