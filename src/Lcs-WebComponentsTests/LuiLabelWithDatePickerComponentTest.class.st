Class {
	#name : #LuiLabelWithDatePickerComponentTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #private }
LuiLabelWithDatePickerComponentTest >> assert: aBlock gives: aString [
	| html |
	html := WAHtmlCanvas builder
		fullDocument: false;
		rootBlock: aBlock;
		render: aBlock.
	self assert: aString equals: html
]

{ #category : #setUp }
LuiLabelWithDatePickerComponentTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #'as yet unclassified' }
LuiLabelWithDatePickerComponentTest >> testAddingSlotModel [
	| component person |
	person := LxxPrototypePerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 1870).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPrototypePerson dateOfBirthSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'dateOfBirth'.
	self assert: component labelComponent labelString equals: 'Date of Birth'.
	self assert: component inputComponent displayValue equals: '1870-01-01'
		
]

{ #category : #'as yet unclassified' }
LuiLabelWithDatePickerComponentTest >> testAddingSlotModelWithUndefinedDateOfBirth [
	| component person |
	person := LxxPrototypePerson new.
	"person dateOfBirth: (Date newDay: 1 month: 1 year: 1870)."
	component := LuiLabelWithInputComponent onSlot: LxxPrototypePerson dateOfBirthSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'dateOfBirth'.
	self assert: component labelComponent labelString equals: 'Date of Birth'.
	"self assert: person dateOfBirth isNil."
	self assert: component inputComponent displayValue equals: ''
		
]

{ #category : #tests }
LuiLabelWithDatePickerComponentTest >> testCreation [
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx' on: nil.
	self assert: component hasLabelComponent.
	self assert: component labelComponent componentName equals: 'label'
]

{ #category : #'as yet unclassified' }
LuiLabelWithDatePickerComponentTest >> testRendering [
	| component person |
	person := LxxPrototypePerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 1870).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPrototypePerson dateOfBirthSlotDefinition.
	component model: person.
	self
		assert: [ :html | html render: component ]
		gives: 'div data-StClass="LuiLabelWithInputComponent"><label id="218106578" data-name="label" data-StClass="LuiModelLabel" for="dateOfBirth">Date of Birth</label><input id="44548918" data-name="input" data-StClass="LuiDatePicker" onchange="this.form.requestSubmit()" name="dateOfBirth" value="1870-01-01" type="date"/></div>'
]
