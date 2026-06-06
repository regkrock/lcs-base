Class {
	#name : 'LuiCheckboxExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiCheckboxExamples >> checkedCheckboxWithNoValue [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="xxxx" checked type="checkbox"/>'.
	component := self newComponent.
	component model: true.
	self assertRendered: component equals: expectedHtml.
	^ component

]

{ #category : 'examples' }
LuiCheckboxExamples >> checkedCheckboxWithValue [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="xxxx" checked value="Label" type="checkbox"/>'.
	component := self newComponent.
	component model: true.
	component text: 'Label'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiCheckboxExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiCheckbox named: 'xxxx'.
	self assert: component hasNoComponents.
	self assert: component componentName equals: 'xxxx'.
	"self assert: component cssClassesString equals: 'inputField'."
	self assert: component valueAccessor class name equals: LuiLocalAccessor name.
	self assert: component valueAccessor parent equals: component.
	self assert: component valueAccessor model equals: nil.
	self assert: component displayValue equals: 'nil'.
	self assert: component componentDecorations hasNoDecorations.
	self assert: component text isNil.
	^ component
]

{ #category : 'examples' }
LuiCheckboxExamples >> newComponentHtml [
	<gtExample>
	| component |
	component := self newComponent.
	self assertRendered: component equals: '<input data-name="xxxx" data-StClass="LuiCheckbox" name="xxxx" type="checkbox"/>'.
	^ component

]

{ #category : 'examples' }
LuiCheckboxExamples >> uncheckedCheckboxWithNoValue [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="xxxx" type="checkbox"/>'.
	component := self newComponent.
	component model: false.
	self assert: component model equals: false.
	"self assertRendered: component equals: expectedHtml."
	^ component

]

{ #category : 'examples' }
LuiCheckboxExamples >> uncheckedCheckboxWithValue [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="xxxx" value="Label" type="checkbox"/>'.
	component := self newComponent.
	component model: false.
	self assert: component model equals: false.
	component text: 'Label'.
	self assertRendered: component equals: expectedHtml.
	^ component

]
