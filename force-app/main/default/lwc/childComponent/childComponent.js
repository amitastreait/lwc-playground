import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api greetMessage = 'Message from Child Component';

    @api
    clickMeChild(message, var1 , var2){
        this.greetMessage = message;
    }

    registerEvent(){
        const event = new CustomEvent('selected', {
            detail: { 
                message : "Message from Child Component using Event"
            }
        });
        this.dispatchEvent(event);
    }
}