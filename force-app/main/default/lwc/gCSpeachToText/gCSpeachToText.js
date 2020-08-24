/**
 * @description       :
 * @author            : Amit Singh
 * @group             :
 * @last modified on  : 08-23-2020
 * @last modified by  : Amit Singh
 * Modifications Log
 * Ver   Date         Author       Modification
 * 1.0   08-23-2020   Amit Singh   Initial Version
 **/
import { LightningElement } from "lwc";

export default class GCSpeachToText extends LightningElement {

  handleClick() {
    console.log(navigator);
    console.log(navigator.mediaDevices);
    navigator.mediaDevices.getUserMedia({ audio: true }).then((stream) => {
      const mediaRecorder = new MediaRecorder(stream);
      mediaRecorder.start();
      console.log('recording starting.....');
      const audioChunks = [];
      mediaRecorder.addEventListener("dataavailable", (event) => {
        audioChunks.push(event.data);
      });

      mediaRecorder.addEventListener("stop", () => {
        const audioBlob = new Blob(audioChunks);
        const audioUrl = URL.createObjectURL(audioBlob);
        const audio = new Audio(audioUrl);
        audio.play();
      });

      setTimeout(() => {
        mediaRecorder.stop();
      }, 3000);
    });
  }

}
