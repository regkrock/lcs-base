Class {
	#name : 'LuiScaledDecimalInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiScaledDecimalInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiScaledDecimalInput new.
	self wrapComponent: component.
	expectedHtml := '<input id="57293099" data-StClass="LuiScaledDecimalInput" class="inputField" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#57293099&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml. 
	^ component
]

{ #category : 'as yet unclassified' }
LuiScaledDecimalInputExamples >> newNamedComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiScaledDecimalInput named: 'xxx'.
	self wrapComponent: component.
	self assert: component displayValue equals: ''.
	expectedHtml := '<input id="163764608" data-name="xxx" data-StClass="LuiScaledDecimalInput" class="inputField" name="1" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;2&quot;,&quot;3=&quot;+encodeURIComponent($(&quot;#163764608&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;4&quot;)}})" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiScaledDecimalInputExamples >> nonzeroScaledDecimalNumberInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	component model balance: 10.01s2.
	self assert: component model balance equals: 10.01s2.
	self assert: component displayValue equals: '10.01'.
	^ component
]

{ #category : 'as yet unclassified' }
LuiScaledDecimalInputExamples >> scaledDecimalWith2DecimalPlacesNumberInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiScaledDecimalInput onSlotNamed: 'balance' model: person.
	self wrapComponent: component.
	self assert: component step equals: 0.01s2.
	self assert: component codec class equals: LuiScaledDecimalCodec.
	self assert: component displayValue equals: '0.00'.
	self assertRendered: component equals: '<input id="117598794" data-name="balance" data-StClass="LuiScaledDecimalInput" step="0.01" class="inputField" max="100" min="-100" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#117598794&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="0.00" type="number"/>'.
	^ component
]

{ #category : 'examples' }
LuiScaledDecimalInputExamples >> updateScaledDecimalWith2DecimalPlacesComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	self assert: component model balance equals: 0.
	component handleCallbackValue: '0.02'.
	self assert: component model balance equals: 0.02s2
]

{ #category : 'examples' }
LuiScaledDecimalInputExamples >> updateScaledDecimalWithOutOrRangeValueComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	self assert: component model balance equals: 0.
	
	component handleCallbackValue: '91'.
	self assert: component model balance equals: 91.00s2
]
