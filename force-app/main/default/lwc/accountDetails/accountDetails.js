/**
 * @File Name          : accountDetails.js
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 21/6/2020, 9:44:45 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    21/6/2020   Amit Singh     Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import fetchAccountDetails from '@salesforce/apex/AccountDetailsService.fetchAccountDetails';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AccountDetails extends LightningElement {
    
    @api recordId;
    @track result;
    @track error;
    /*
        result - Non-premitives ( String, Integer )
        @track - array, objects
    */
    
    @wire(fetchAccountDetails, { recordId : '$recordId' })
    wiredData({ error, data }) {
      if (data) {
        if(Array.isArray(data)){
            this.result = data;
        }
        this.error = undefined;
        window.console.log(' data ', data)
      } else if (error) {
        this.error = error;
        window.console.log(' error ', error)
        this.result = undefined;
      }
    }

    handleGenerateReport(){
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success!!',
            message: 'Report Generated',
            variant: 'success'
        }));
    }
}