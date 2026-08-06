Class {
	#name : 'LuiNumberInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiNumberInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiNumberInput new.
	self wrapComponent: component.
	expectedHtml := '<input id="57293099" data-StClass="LuiNumberInput" class="inputField" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#57293099&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml. 
	^ component
]

{ #category : 'as yet unclassified' }
LuiNumberInputExamples >> newNamedComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiNumberInput named: 'xxx'.
	self wrapComponent: component.
	self assert: component displayValue equals: ''.
	expectedHtml := '<input id="163764608" data-name="xxx" data-StClass="LuiNumberInput" class="inputField" name="1" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;2&quot;,&quot;3=&quot;+encodeURIComponent($(&quot;#163764608&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;4&quot;)}})" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiNumberInputExamples >> numberInputForInteger_PersonWeight [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiNumberInput onSlotNamed: 'weight' model: person.
	self wrapComponent: component.
	component dependentComponents removeAll.
	self assert: component step equals: 1.
	self assert: component displayValue equals: '180'.
	self assertRendered: component equals: '<input id="166924512" data-name="weight" data-StClass="LuiNumberInput" step="1" class="inputField" max="500" min="0" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#166924512&quot;).val())].join(&quot;&amp;&quot;)})" value="180" type="number"/>'.
	^ component
]
