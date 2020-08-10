/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-19-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-15-2020   Amit Singh   Initial Version
**/
import { LightningElement } from 'lwc';
import readBusinessCardBase64 from '@salesforce/apex/EinsteinOCRService.readBusinessCardBase64';
import readTextFromImageByBase64 from '@salesforce/apex/EinsteinOCRService.readTextFromImageByBase64';
export default class EinsteinOCR extends LightningElement {

    resultCard;
    fileReader;
    fileContents;
    content;
    file;
    errors;
    MAX_FILE_SIZE = 1500000;
    sizeLongMessage;
    isLoading = false;
    fileLabel = 'Upload Image'
    fileName = 'file not selected'
    isBusinessCarrd = false;
    value = 'Contact';

    get options() {
        return [
            { label: 'Contact', value: 'Contact' },
            { label: 'Lead', value: 'Lead' }
        ];
    }

    handleChangePick(event){
        this.value = event.target.value;
    }

    handleChange(event){
        this.isBusinessCarrd = event.target.checked;
    }

    handleFilesChange(event){
        this.file = event.target.files[0];
        this.fileName = event.target.files[0]['name'];
    }

    startPrediction(){
        if (this.file.size > this.MAX_FILE_SIZE) {
            this.sizeLongMessage = this.file.size+' File Size is to long';
            return ;
        }
        this.isLoading = true;
        this.fileReader= new FileReader();

        this.fileReader.onloadend = (() => {
            this.fileContents = this.fileReader.result;
            let base64 = 'base64,';
            this.content = this.fileContents.indexOf(base64) + base64.length;
            this.fileContents = this.fileContents.substring(this.content);
            if(this.isBusinessCarrd){
                this.readBinaryFile(this.fileContents);
            }else{
                this.readImageFROMOCR(this.fileContents);
            }
        });
        this.fileReader.readAsDataURL(this.file);
    }

    readImageFROMOCR(binaryData){
        readTextFromImageByBase64({
            sample : binaryData
        })
        .then(result => {
            let returnedData = JSON.parse(result);
            this.resultCard = result? JSON.stringify(returnedData, undefined, 4): "no prediction found";
            let textArea = this.template.querySelector('textarea');
            textArea.innerHTML = this.resultCard;
            this.errors = undefined;
            console.log({
                message : 'Response From Einstin Plarform API',
                data : result
            });
        })
        .catch(error => {
            this.errors = JSON.stringify(error);
            this.resultCard = undefined;
            console.error({
                message : 'Error Occured While making callout to Einstein API',
                data : error
            })
        })
        .finally(()=>{
            this.isLoading = false;
        })
    }

    readBinaryFile(binaryData){
        readBusinessCardBase64({
            sampleBusinessCard : binaryData,
            objectName : this.value
        })
        .then(result => {
            let returnedData = JSON.parse(result.response);
            //let returnedDataRecord = JSON.parse(result.record);
            let resultCard1 = result? JSON.stringify(returnedData, undefined, 4): "no prediction found";
            this.resultRecord = result? JSON.stringify(result.record, undefined, 4): "no prediction found";
            
            let textArea = this.template.querySelector('textarea');
            textArea.innerHTML = resultCard1;

            let txtArea = this.template.querySelector('.recordDetailsClass');
            txtArea.innerHTML = this.resultRecord;
            this.errors = undefined;

            console.log({
                message : 'Response From Einstin Plarform API',
                data : result
            });
        })
        .catch(error => {
            this.errors = error;
            this.resultCard = undefined;
            console.error({
                message : 'Error Occured While making callout to Einstein API',
                data : error
            })
        })
        .finally(()=>{
            this.isLoading = false;
        })
    }
}