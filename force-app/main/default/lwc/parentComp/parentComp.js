import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {

    message = 'message from parent component';
    childmessage = '';
    handleClick(){
        //this.message = 'Value Changed';
        let childComp = this.template.querySelector('c-child-component');
        childComp.clickMeChild('Value Changed', '1', '2');
        /*
            GetAccounts()
            AccountController controller = AccountController();
            controller.GetAccounts();
        */
    }
    handleEvent(event){
        let messagefromChild = event.detail.message;
        this.childmessage = messagefromChild;
    }
}