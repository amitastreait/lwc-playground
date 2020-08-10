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
import { LightningElement, api } from 'lwc';

export default class ChildGet extends LightningElement {

    uppercaseItemName;

    @api
    get itemName() {
        return this.uppercaseItemName;
    }

    set itemName(value) {
       this.uppercaseItemName = value.toUpperCase();
    }

    handleClick(){
        this.itemName = 'I have been changed from Child Component';
    }
}