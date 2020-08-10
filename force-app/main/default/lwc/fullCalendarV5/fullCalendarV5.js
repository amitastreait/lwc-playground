/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 07-12-2020
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   07-12-2020   Amit Singh   Initial Version
**/
import { LightningElement } from 'lwc';
import fullCalendarV5 from '@salesforce/resourceUrl/fullCalendarV5';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
export default class FullCalendarV5 extends LightningElement {
    fullCalendarJsInitialised = false;
    renderedCallback() {

        // Performs this operation only on first render
        if (this.fullCalendarJsInitialised) {
          return;
        }
        this.fullCalendarJsInitialised = true;
    
        // Executes all loadScript and loadStyle promises
        // and only resolves them once all promises are done
        Promise.all([
          loadScript(this, fullCalendarV5 + '/jquery.min.js'),
          loadScript(this, fullCalendarV5 + '/moment.min.js'),
          loadScript(this, fullCalendarV5 + '/locales-all.js'),
          loadScript(this, fullCalendarV5 + '/locales-all.min.js'),
          loadScript(this, fullCalendarV5 + '/main.js'),
          loadScript(this, fullCalendarV5 + '/main.min.js'),
          loadScript(this, fullCalendarV5 + '/js/theme.js'),
          loadStyle(this, fullCalendarV5 + '/main.css'),
          loadStyle(this, fullCalendarV5 + '/main.min.css'),
        ])
        .then(() => {
          window.console.log('Libs Loaded');
        })
        .catch(error => {
          // eslint-disable-next-line no-console
          console.error({
            message: 'Error occured on FullCalendarJS',
            error
          });
        })
      }
}