Class {
	#name : 'LuiDatePickerFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#instVars : [
		'savedSystem'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiDatePickerFunctionalTest >> initialize [
	| item person button label |
	super initialize.
	self switchToPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 2 month: 8 year: 1955).
	person lastName: 'Freeman'.
	self componentName: 'root'.
	self componentId: 'root'.
	label := (LuiLabel named: 'dateOfBirthLabel').
	label valueAccessor
		model: person;
		slotName: 'dateOfBirth'.
	self addComponent: label.
	item := LuiDatePicker named: 'dateOfBirth'.
	item valueAccessor 
		model: person;
		slotName: 'dateOfBirth'.
	self addComponent: item.
	button := 
		(LuiPushButton named: 'button') 
			beButtonType; 
			labelString: 'OK'; 
			yourself.
	self addComponent: button.
	^ self
]

{ #category : 'accessing' }
LuiDatePickerFunctionalTest >> savedSystem: aSystem [ 
	savedSystem := aSystem
]

{ #category : 'initialize' }
LuiDatePickerFunctionalTest >> switchToPrototypeSystem [
	System abortTransaction.
	LcsApplicationEnvironment ensureInitialized.
	LcsApplicationEnvironment currentSystem isPrototypeSystem ifFalse: [
		self savedSystem: LcsApplicationEnvironment suspendCurrentSystem.
		LxxPrototypeSystem new].
	System commitTransaction
]
