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
	expectedHtml := '<input data-StClass="LuiNumberInput" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml. 
	^ component
]

{ #category : 'as yet unclassified' }
LuiNumberInputExamples >> newNamedComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiNumberInput named: 'xxx'.
	self assert: component displayValue equals: ''.
	expectedHtml := '<input data-name="xxx" data-StClass="LuiNumberInput" name="xxx" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiNumberInputExamples >> nonzeroScaledDecimalNumberInputComponent [
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
LuiNumberInputExamples >> scaledDecimalWith2DecimalPlacesNumberInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiNumberInput onSlotNamed: 'balance' model: person.
	self assert: component step equals: 0.01s2.
	self assert: component converter class equals: LuiScaledDecimalStringConverter.
	self assert: component displayValue equals: '0.00'.
	self assertRendered: component equals: '<input data-name="balance" data-StClass="LuiNumberInput" max="100" name="1" min="0" step="0.01" value="0.00" type="number"/>'.
	^ component
]

{ #category : 'examples' }
LuiNumberInputExamples >> updateScaledDecimalWith2DecimalPlacesComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	self assert: component model balance equals: 0.
	component handleCallbackValue: '0.02'.
	self assert: component model balance equals: 0.02s2
]

{ #category : 'examples' }
LuiNumberInputExamples >> updateScaledDecimalWithOutOrRangeValueComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	self assert: component model balance equals: 0.
	
	component handleCallbackValue: '101'.
	self assert: component model balance equals: 101.00s2
]
