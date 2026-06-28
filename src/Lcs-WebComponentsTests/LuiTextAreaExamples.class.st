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
	expectedHtml := '<textarea rows="auto" cols="auto" data-name="xxx" data-StClass="LuiTextArea" name="1">abc</textarea>'.
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

	expectedHtml := '<input data-name="comment" data-StClass="LuiTextInput" placeholder="Comment" class="inputField" name="1" value="" type="text"/>'.
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
