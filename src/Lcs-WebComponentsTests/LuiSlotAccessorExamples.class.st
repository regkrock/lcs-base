Class {
	#name : 'LuiSlotAccessorExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSlotAccessorExamples >> accessingBooleanSlot [
	<gtExample>
	<after: #clearUnitOfWork>
	| accessor person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	person hasRedHair: true.
	self assert: person hasRedHair.
	accessor := self newAccessor.
	accessor slotDefinition: (person slotDefinitionNamed: 'hasRedHair').
	self assert: accessor model isNil.
	accessor model: person.
	self assert: accessor model equals: person.
	self assert: accessor readSelector equals: #hasRedHair.
	self assert: accessor writeSelector equals: #hasRedHair:.
	
	self assert: accessor read equals: true.
	self assert: accessor contents equals: true.
	self assert: accessor displayValue equals: 'true'.
	^ accessor
]

{ #category : 'examples' }
LuiSlotAccessorExamples >> accessingBooleanSlotFromLuiWidget [
	<gtExample>
	<after: #clearUnitOfWork>
	| accessor person component |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	person hasRedHair: true.
	self assert: person hasRedHair.
	
	component := LuiCheckbox onSlotNamed: 'hasRedHair' model: person. 
	accessor := component valueAccessor.
	self assert: accessor model equals: person.
	self assert: accessor defactoModel equals: person.	self assert: accessor readSelector equals: #hasRedHair.
	self assert: accessor writeSelector equals: #hasRedHair:.
	
	self assert: accessor read equals: true.
	self assert: accessor contents equals: true.
	self assert: accessor displayValue equals: 'true'.
	^ component
]

{ #category : 'examples' }
LuiSlotAccessorExamples >> newAccessor [
	<gtExample>
	| accessor |
	accessor := LuiSlotAccessor new.
	self assert: accessor model isNil.
	self assert: accessor readSelector isNil.
	self assert: accessor writeSelector isNil.
	^ accessor
]

{ #category : 'examples' }
LuiSlotAccessorExamples >> updatingBooleanSlot [
	<gtExample>
	<after: #clearUnitOfWork>
	| accessor |
	accessor := self accessingBooleanSlot.

	accessor write: false.
	
	self assert: accessor read equals: false.
	self assert: accessor contents equals: false.
	self assert: accessor displayValue equals: 'false'.
	^ accessor
]

{ #category : 'examples' }
LuiSlotAccessorExamples >> updatingBooleanSlotFromLuiWidget [
	<gtExample>
	<after: #clearUnitOfWork>
	| accessor person component |	
	component := self accessingBooleanSlotFromLuiWidget. 
	accessor := component valueAccessor.	
	accessor write: false.
	self assert: accessor read equals: false.
	self assert: accessor contents equals: false.
	self assert: accessor displayValue equals: 'false'.
	^ component
]
