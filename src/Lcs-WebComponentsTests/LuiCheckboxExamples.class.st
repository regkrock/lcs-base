Class {
	#name : 'LuiCheckboxExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiCheckboxExamples >> checkboxOnBooleanSlot [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	expectedHtml := ''.
	component := LuiCheckbox onSlotNamed: 'hasRedHair' model: person.
	^ component

]

{ #category : 'examples' }
LuiCheckboxExamples >> checkboxOnBooleanSlotWhereBooleanIsTrue [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	person hasRedHair: true.
	self assert: person hasRedHair.
	expectedHtml := ''.
	component := LuiCheckbox onSlotNamed: 'hasRedHair' model: person.
	^ component

]

{ #category : 'examples' }
LuiCheckboxExamples >> checkedCheckboxWithNoValue [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="1" checked type="checkbox"/><input name="2" type="hidden"/>'.
	component := LuiCheckbox named: 'xxxx' model: true.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiCheckboxExamples >> checkedCheckboxWithValue [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="1" checked type="checkbox"/><input name="2" type="hidden"/>'.
	component := LuiCheckbox named: 'xxxx' model: true.
	component model: true.
	self assertRendered: component equals: expectedHtml.
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
	self assert: component valueAccessor class name equals: LuiSmalltalkObjectAccessor name.
	self assert: component valueAccessor parent equals: component.
	self assert: component valueAccessor model equals: nil.
	self assert: component valueAccessor contents equals: nil.
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
	self assertRendered: component equals: '<input data-name="xxxx" data-StClass="LuiCheckbox" name="1" type="checkbox"/><input name="2" type="hidden"/>'.
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
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiCheckbox" name="1" type="checkbox"/><input name="2" type="hidden"/>'.
	component := self newComponent.
	component model: false.
	self assert: component model equals: false.
	component text: 'Label'.
	self assertRendered: component equals: expectedHtml.
	^ component

]
