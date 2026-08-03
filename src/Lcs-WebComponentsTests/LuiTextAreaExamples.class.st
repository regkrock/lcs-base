Class {
	#name : 'LuiTextAreaExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTextAreaExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiTextArea named: 'xxx' model: 'abc'.
	self wrapComponent: component.
	expectedHtml := '<textarea rows="auto" cols="auto" id="163764608" data-name="xxx" data-StClass="LuiTextArea" name="1" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;2&quot;,&quot;3=&quot;+encodeURIComponent($(&quot;#163764608&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;4&quot;)}})">abc</textarea>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTextAreaExamples >> textAreaOnPersonComment [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	self assert: person comment equals: '' asText.
	component := LuiTextInput onSlotNamed: 'comment' model: person.
	self wrapComponent: component.

	expectedHtml := '<input id="13798335" data-name="comment" data-StClass="LuiTextInput" placeholder="Comment" class="inputField" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#13798335&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="" type="text"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTextAreaExamples >> updateTextAreaOnPersonComment [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	self ensureCurrentSystemIsPrototypeSystem.
	component := self textAreaOnPersonComment.
	component handleCallbackValue: 'test comment'.
	self assert: component model comment equals: 'test comment' asText.
	^ component
]
