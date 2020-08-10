<aura:application extends="force:slds">
    <div class="slds-m-around_large">
        <c:parentComp/>
    </div>
    <aura:attribute name="WholeNumber" type="integer" access="public"/>
    <aura:attribute name="percentage" type="integer" access="public"/>
    
    
    <div class="slds-p-around_large">
        <lightning:input type="number" name="input1" label="Enter a number" 
                         value="{!v.WholeNumber}"/>
        <lightning:input type="number" name="input1" label="Enter percentage"
                         value="{!v.percentage}" formatter="percent-fixed"/> 
        
        {!v.WholeNumber}<br/>
        {!v.percentage}
        <br/>
        {!mult(v.WholeNumber, v.percentage)}
    </div> 
</aura:application>