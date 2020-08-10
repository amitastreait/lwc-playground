/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-05-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-05-2020   Amit Singh   Initial Version
**/
import { LightningElement, track } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
export default class EmpApi extends LightningElement {
    channelName = '/event/AccountChangeEvent';
    isSubscribeDisabled = false;
    isUnsubscribeDisabled = !this.isSubscribeDisabled;
    error = undefined;

    @track recordlist;

    subscription = {};

    // Tracks changes to channelName text field
    handleChannelName(event) {
        this.channelName = event.target.value;
    }

    connectedCallback() {            
        this.registerErrorListener();      
    }
    handleSubscribe() {
        const messageCallback = (response) =>{
            console.log('New message received: ', JSON.stringify(response.data.payload));
            this.error = undefined;
        };

        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
            this.toggleSubscribeButton(true);
        });
    }

    handleUnsubscribe() {
        this.toggleSubscribeButton(false);
        unsubscribe(this.subscription, response => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
        });
    }

    toggleSubscribeButton(enableSubscribe) {
        this.isSubscribeDisabled = enableSubscribe;
        this.isUnsubscribeDisabled = !enableSubscribe;
    }

    registerErrorListener() {
        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
            this.error = JSON.stringify(error);
        });
    }
}