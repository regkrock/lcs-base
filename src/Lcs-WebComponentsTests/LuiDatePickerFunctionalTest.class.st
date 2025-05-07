Class {
	#name : #LuiDatePickerFunctionalTest,
	#superclass : #LuiFunctionalTest,
	#instVars : [
		'savedSystem'
	],
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #initialize }
LuiDatePickerFunctionalTest >> initialize [
	| item person button label |
	super initialize.
	self switchToPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 2 month: 8 year: 1955).
	person lastName: 'Freeman'.
	self componentName: 'root'.
	self componentId: 'root'.
	label := (LuiModelLabel named: 'dateOfBirthLabel' on: self).
	label valueAccessor
		model: person;
		slotName: 'dateOfBirth'.
	self addComponent: label.
	item := LuiDatePicker named: 'dateOfBirth' on: self.
	item valueAccessor 
		model: person;
		slotName: 'dateOfBirth'.
	self addComponent: item.
	button := 
		(LuiPushButton named: 'button' on: self) 
			beButtonType; 
			labelString: 'OK'; 
			yourself.
	self addComponent: button.
	^ self
]

{ #category : #accessing }
LuiDatePickerFunctionalTest >> savedSystem: aSystem [ 
	savedSystem := aSystem
]

{ #category : #initialize }
LuiDatePickerFunctionalTest >> switchToPrototypeSystem [
	System abortTransaction.
	LcsApplicationEnvironment ensureInitialized.
	LcsApplicationEnvironment currentSystem isPrototypeSystem ifFalse: [
		self savedSystem: LcsApplicationEnvironment suspendCurrentSystem.
		LxxPrototypeSystem new].
	System commitTransaction
]

{ #category : #updating }
LuiDatePickerFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
