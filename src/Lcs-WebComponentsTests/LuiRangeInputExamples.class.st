Class {
	#name : 'LuiRangeInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiRangeInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := (LuiRangeInput named: 'rangeWidget' model: 5)
					min: 1;
					max: 10;
					step: 1.
	self assert: component callback printString equals: '[ :value | self handleCallbackValue: value ]'.

	expectedHtml := '<input data-name="rangeWidget" data-StClass="LuiRangeInput" max="10" step="1" min="1" name="1" value="5" type="range"/>'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiRangeInputExamples >> weightRange [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	component := LuiRangeInput onSlotNamed: 'weight' model: person.
	self wrapComponent: component.
	expectedHtml := '<input id="166924512" data-name="weight" data-StClass="LuiRangeInput" min="0" max="500" class="inputField" step="1" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#166924512&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="0" type="range"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]
