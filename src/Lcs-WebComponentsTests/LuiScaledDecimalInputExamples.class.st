Class {
	#name : 'LuiScaledDecimalInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiScaledDecimalInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiScaledDecimalInput new.
	expectedHtml := '<input data-StClass="LuiScaledDecimalInput" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml. 
	^ component
]

{ #category : 'as yet unclassified' }
LuiScaledDecimalInputExamples >> newNamedComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiScaledDecimalInput named: 'xxx'.
	self assert: component displayValue equals: ''.
	expectedHtml := '<input data-name="xxx" data-StClass="LuiScaledDecimalInput" name="1" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiScaledDecimalInputExamples >> nonzeroScaledDecimalNumberInputComponent [
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
LuiScaledDecimalInputExamples >> scaledDecimalWith2DecimalPlacesNumberInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiScaledDecimalInput onSlotNamed: 'balance' model: person.
	self assert: component step equals: 0.01s2.
	self assert: component toStringConverter class equals: LuiScaledDecimalStringConverter.
	self assert: component fromStringConverter class equals: LuiScaledDecimalStringConverter.
	self assert: component displayValue equals: '0.00'.
	self assertRendered: component equals: '<input data-name="balance" data-StClass="LuiScaledDecimalInput" step="0.01" max="100" min="-100" name="1" value="0.00" type="number"/>'.
	^ component
]

{ #category : 'examples' }
LuiScaledDecimalInputExamples >> updateScaledDecimalWith2DecimalPlacesComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	self assert: component model balance equals: 0.
	component handleCallbackValue: '0.02'.
	self assert: component model balance equals: 0.02s2
]

{ #category : 'examples' }
LuiScaledDecimalInputExamples >> updateScaledDecimalWithOutOrRangeValueComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self scaledDecimalWith2DecimalPlacesNumberInputComponent.
	self assert: component model balance equals: 0.
	
	component handleCallbackValue: '91'.
	self assert: component model balance equals: 91.00s2
]
