/**
 * @File Name          : caseDatatable.js
 * @Description        : 
 * @Author             : Amit Singh
 * @Group              : 
 * @Last Modified By   : Amit Singh
 * @Last Modified On   : 23/6/2020, 3:40:39 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    23/6/2020   Amit Singh     Initial Version
**/
import { LightningElement, wire, api, track } from 'lwc';
import fetchCases from '@salesforce/apex/CaseLWCService.fetchCases';

const columns = [
    { 
        label: 'CaseNumber', fieldName: 'caseUrl', type:'url',
        typeAttributes: {
            label: { 
                fieldName: 'CaseNumber' 
            },
            target : '_blank'
        }
    },
    { 
        label: 'Subject', fieldName: 'caseUrl', wrapText: true,
        type: 'url',
        typeAttributes: {
            label: { 
                fieldName: 'Subject' 
            },
            target : '_blank'
        }
    },
    { label: 'Status', fieldName: 'Status' },
    {
        label: 'Priority', fieldName: 'Priority',
        cellAttributes:{ 
            iconName: { 
                fieldName: 'priorityIcon' 
            },
            iconPosition: 'left', 
            iconAlternativeText: 'Priority Icon' 
        }
    },
    { 
        label: 'Contact', fieldName: 'ContactUrl', wrapText: true,
        type: 'url',
        typeAttributes: {
            label: { 
                fieldName: 'ContactName' 
            },
            target : '_blank'
        } 
    },
    { 
        label: 'Account', fieldName: 'AccountUrl', wrapText: true,
        type: 'url',
        typeAttributes: {
            label: { 
                fieldName: 'AccountName' 
            },
            target : '_blank'
        } 
    }
];


            

export default class CaseDatatable extends LightningElement {
    
    @api result;
    @track error;

    columnsList = columns;
    
    connectedCallback(){
        this.getAllCaseDetails();
    }

    getAllCaseDetails(){
        fetchCases()
            .then(data => {
                /* Iterate with Each record and check if the Case is Associated with Account or Contact
                    then get the Name and display into datatable
                */
                /* Prepare the Org Host */
                let baseUrl = 'https://'+location.host+'/';
                data.forEach(caseRec => {
                    caseRec.caseUrl = baseUrl+caseRec.Id;
                    if(caseRec.ContactId){
                        caseRec.ContactName = caseRec.Contact.Name;
                        /* Prepare Contact Detail Page Url */
                        caseRec.ContactUrl = baseUrl+caseRec.ContactId;
                    }
                    if(caseRec.AccountId){
                        caseRec.AccountName = caseRec.Account.Name;
                        /* Prepare Account Detail Page Url */
                        caseRec.AccountUrl = baseUrl+caseRec.AccountId;
                    }

                    if(caseRec.Priority === 'High'){
                        caseRec.priorityIcon = 'utility:log_a_call';
                    } else if (caseRec.Priority === 'Medium'){
                        caseRec.priorityIcon = 'utility:note';
                    } else if(caseRec.Priority === 'Low'){
                        caseRec.priorityIcon = 'utility:open';
                    }
                });
                this.result = data;
                window.console.log(' data ', data);
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                window.console.log(' error ', error);
                this.result = undefined;
            });
    }
    
    handleRowAction(){
        
    }
}