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
import { LightningElement } from 'lwc';

export default class ParentGet extends LightningElement {
    itemName = 'I am from Parent Compponent';

    handleChangeComp(){
        this.itemName = 'Now again Changed from Parent Component';
    }
}