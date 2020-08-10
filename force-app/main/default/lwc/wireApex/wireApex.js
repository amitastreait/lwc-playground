/**
 * @File Name          : wireApex.js
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 24/6/2020, 5:28:38 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    24/6/2020   Amit Singh     Initial Version
**/
import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList';
  
export default class WireApex extends LightningElement {
  accounts;
  error;
  
  @wire(getAccountList)
  wiredAccounts({ error, data }) {
    if(data) {
      this.accounts = data;
      this.error = undefined;
    } else if(error) {
      this.error = error;
      this.accounts = undefined;
    }
  }
}