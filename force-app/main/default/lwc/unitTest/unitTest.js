/* eslint-disable @lwc/lwc/no-api-reassignments */
/**
 * @File Name          : unitTest.js
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 24/6/2020, 5:20:12 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    24/6/2020   Amit Singh     Initial Version
**/
import { LightningElement, api } from 'lwc';
import { sum } from './sum';
  
export default class UnitTest extends LightningElement {
    
  @api unitNumber = sum(2,3);
  handleChange(event) {
    this.unitNumber = event.target.value;
  }
}