Class {
	#name : #LuiLabelWithInputComponentTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #private }
LuiLabelWithInputComponentTest >> assert: aBlock gives: aString [
	| html |
	html := WAHtmlCanvas builder
		fullDocument: false;
		rootBlock: aBlock;
		render: aBlock.
	self assert: aString equals: html
]

{ #category : #setUp }
LuiLabelWithInputComponentTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponentTest >> testAddingSlotModel [
	| component person |
	person := LxxPrototypePerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 1870).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPrototypePerson lastNameSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'lastName'.
	self assert: component labelComponent labelString equals: 'Last Name'.
	self assert: component inputComponent displayValue equals: 'Smith'
		
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponentTest >> testAddingSlotModelWithUndefinedLastName [
	| component person |
	person := LxxPrototypePerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 1870).
	component := LuiLabelWithInputComponent onSlot: LxxPrototypePerson lastNameSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'lastName'.
	self assert: component labelComponent labelString equals: 'Last Name'.
	self assert: component inputComponent displayValue equals: ''
		
]

{ #category : #tests }
LuiLabelWithInputComponentTest >> testCreation [
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx' on: nil.
	self assert: component hasLabelComponent.
	self assert: component labelComponent componentName equals: 'label'
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponentTest >> testRendering [
	| component person |
	person := LxxPrototypePerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 1870).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPrototypePerson lastNameSlotDefinition.
	component model: person.

	self
		assert: [ :html | html render: component ]
		gives: '<div data-StClass="LuiLabelWithInputComponent"><label id="218106578" data-name="label" data-StClass="LuiModelLabel" for="lastName">Last Name</label><input id="44548918" data-name="input" data-StClass="LuiTextInput" name="lastName" value="Smith" type="text"/></div>'
]
