Class {
	#name : 'LuiDateInputFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#instVars : [
		'savedSystem'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiDateInputFunctionalTest >> initialize [
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
	item := LuiDateInput named: 'dateOfBirth'.
	item valueAccessor 
		model: person;
		slotName: 'dateOfBirth'.
	self addComponent: item.
	button := 
		(LuiButton named: 'button') 
			beButtonType; 
			text: 'OK'; 
			yourself.
	self addComponent: button.
	^ self
]

{ #category : 'accessing' }
LuiDateInputFunctionalTest >> savedSystem: aSystem [ 
	savedSystem := aSystem
]

{ #category : 'initialize' }
LuiDateInputFunctionalTest >> switchToPrototypeSystem [
	System abortTransaction.
	LcsApplicationEnvironment ensureInitialized.
	LcsApplicationEnvironment currentSystem isPrototypeSystem ifFalse: [
		self savedSystem: LcsApplicationEnvironment suspendCurrentSystem.
		LxxPrototypeSystem new].
	System commitTransaction
]
