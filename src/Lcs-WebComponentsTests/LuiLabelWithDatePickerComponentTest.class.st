Class {
	#name : #LuiLabelWithDatePickerComponentTest,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
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
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPerson dateOfBirthSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'dateOfBirth'.
	self assert: component labelComponent labelString equals: 'Date of Birth'.
	self assert: component inputComponent displayValue equals: (Date newDay: 1 month: 1 year: 2000) yyyymmdd
		
]

{ #category : #'as yet unclassified' }
LuiLabelWithDatePickerComponentTest >> testAddingSlotModelWithDefaultDateOfBirth [
	| component person |
	person := LxxPerson new.
	"person dateOfBirth: (Date newDay: 1 month: 1 year: 1870)."
	component := LuiLabelWithInputComponent onSlot: LxxPerson dateOfBirthSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'dateOfBirth'.
	self assert: component labelComponent labelString equals: 'Date of Birth'.
	"self assert: person dateOfBirth isNil."
	self assert: component inputComponent displayValue equals: Date today yyyymmdd
		
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
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPerson dateOfBirthSlotDefinition.
	component model: person.
	self
		assert: [ :html | html render: component ]
		gives: '<div data-StClass="LuiLabelWithInputComponent"><label id="218106578" data-name="label" data-StClass="LuiModelLabel" for="dateOfBirth">Date of Birth</label><input id="44548918" data-name="input" data-StClass="LuiDatePicker" name="1" onchange="this.form.requestSubmit()" value="2000-01-01" type="date"/></div>'
]
