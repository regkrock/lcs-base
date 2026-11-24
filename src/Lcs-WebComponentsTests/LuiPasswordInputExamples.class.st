Class {
	#name : 'LuiPasswordInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiPasswordInputExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiPasswordInput named: 'xxxx'.
	self assert: component hasNoComponents.
	self assert: component componentName equals: 'xxxx'.
	self assert: component cssClassesString equals: 'inputField'.
	self assert: component valueAccessor class name equals: LuiSmalltalkObjectAccessor name.
	self assert: component valueAccessor parent equals: component.
	self assert: component valueAccessor model equals: ''.
	self assert: component displayValue equals: ''.
	self assert: (component componentDecorations hasOnlyDependentComponent: component).
	self assert: component autocomplete isNil.
	self assertRendered: component equals: '<input data-name="xxxx" data-StClass="LuiPasswordInput" class="inputField" name="1" value="" type="password"/>'.
	component beCurrentPasswordAutocomplete.
	self assert: component autocomplete equals: 'current-xxxx'.
	self assertRendered: component equals: '<input data-name="xxxx" data-StClass="LuiPasswordInput" autocomplete="current-xxxx" class="inputField" name="1" value="" type="password"/>'.
	component beNewPasswordAutocomplete.
	self assert: component autocomplete equals: 'new-xxxx'.
	self assertRendered: component equals: '<input data-name="xxxx" data-StClass="LuiPasswordInput" autocomplete="new-xxxx" class="inputField" name="1" value="" type="password"/>'.
	component beNoAutocomplete.
	self assert: component autocomplete equals: nil.
	^ component
]

{ #category : 'examples' }
LuiPasswordInputExamples >> newComponentOnSlot [
	<gtExample>
	<after: #clearUnitOfWork>
	| component loginProcess inputComponentClass|
	self ensureCurrentSystemIsPrototypeSystem.
	loginProcess := LcsLoginProcess new.
	inputComponentClass := LcsLoginProcess passwordSlotDefinition inputComponentClass.
	self assert: inputComponentClass equals: LuiPasswordInput.
	component := inputComponentClass onSlot: (loginProcess slotDefinitionNamed: 'password').
	self assert: component hasNoComponents.
	self assert: component componentName equals: 'password'.
	self assert: component cssClassesString equals: 'inputField'.
	self assert: (component componentDecorations hasDependentComponent: component).

	self assert: component valueAccessor class name equals: LuiSlotAccessor name.
	self assert: component valueAccessor parent equals: component.
	self assert: component valueAccessor slotName equals: 'password'.
	self assert: component valueAccessor readSelector equals: 'password'.
	self assert: component valueAccessor writeSelector equals: 'password:'.
	
	self assert: component model isNil.
	component model: loginProcess.
	self assert: component valueAccessor model equals: loginProcess.
	self assert: component displayValue equals: ''.

	^ component
]
