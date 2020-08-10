/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-24-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-24-2020   Amit Singh   Initial Version
**/
import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountLWCService.getAccountList';
import getRelatedContact from '@salesforce/apex/AccountLWCService.getRelatedContact';
export default class MTXDemo extends LightningElement {

    @track accounts;
    error = undefined;
    @track  contacts;
    @wire(getAccountList)
    wiredData({ error, data }) {
      if (data) {
          console.log('data ', data);
        this.accounts = data;
        this.error = undefined;
      } else if (error) {
        this.error = error;
        this.accounts = undefined;
      }
    }

    handleCheckboxChange(event){
        let _accountId = event.target.dataset.recordId;
        alert(_accountId);
        console.log(' _accountId ', _accountId)
        getRelatedContact({ accountId : _accountId })
          .then(result => {
            window.console.log(result)
            this.contacts  = result;
          })
          .catch(error => {
            this.error = error;
            this.contacts = undefined;
        });
    }
}