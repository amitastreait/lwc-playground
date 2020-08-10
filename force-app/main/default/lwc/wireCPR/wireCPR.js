/**
 * @File Name          : wireCPR.js
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 24/6/2020, 5:25:10 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    24/6/2020   Amit Singh     Initial Version
**/
import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
  
export default class WireCPR extends LightningElement {
  @wire(CurrentPageReference) pageRef;
  get currentPageRef() {
    return this.pageRef ? JSON.stringify(this.pageRef, null, 2) : '';
  }
}