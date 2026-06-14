Class {
	#name : 'LuiTextInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTextInputExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiTextInput named: 'xxxx'.
	self assert: component hasNoComponents.
	self assert: component componentName equals: 'xxxx'.
	self assert: component cssClassesString equals: 'inputField'.
	self assert: component valueAccessor class name equals: LuiSmalltalkObjectAccessor name.
	self assert: component valueAccessor parent equals: component.
	self assert: component valueAccessor model equals: ''.
	self assert: component displayValue equals: ''.
	self assert: component componentDecorations hasNoDecorations.
	^ component
]

{ #category : 'examples' }
LuiTextInputExamples >> newComponentOnAString [
	<gtExample>
	| component |
	component := self newComponent.
	component model: 'Hello'.
	self assert: component model equals: 'Hello'.
	self assert: component displayValue equals: 'Hello'.
	^ component
]

{ #category : 'examples' }
LuiTextInputExamples >> newComponentOnSlot [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	
	component := LuiTextInput onSlot: LxxPerson lastNameSlotDefinition.
	self assert: component hasNoComponents.
	self assert: component componentName equals: 'lastName'.
	self assert: component cssClassesString equals: 'inputField'.
	self assert: component componentDecorations hasNoDecorations.

	self assert: component valueAccessor class name equals: LuiSlotAccessor name.
	self assert: component valueAccessor parent equals: component.
	self assert: component valueAccessor slotName equals: 'lastName'.
	self assert: component valueAccessor readSelector equals: 'lastName'.
	self assert: component valueAccessor writeSelector equals: 'lastName:'.
	
	self assert: component model isNil.
	component model: person.
	self assert: component valueAccessor model equals: person.
	self assert: component displayValue equals: 'Smith'.

	^ component
]
