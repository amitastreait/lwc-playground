/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-03-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-03-2020   Amit Singh   Initial Version
**/
import { LightningElement } from 'lwc';
import D3 from '@salesforce/resourceUrl/D3';
import { loadScript } from 'lightning/platformResourceLoader';
export default class D3MainComp extends LightningElement {
    isRendered;

    renderedCallback(){
        if(!this.isRendered){
            loadScript(this, D3)
            .then(()=>{

            })
            .catch((error)=>{
                window.console.error(error);
            })
            .finally(()=>{
                
            });
            this.isRendered = true;
        }
    }
}