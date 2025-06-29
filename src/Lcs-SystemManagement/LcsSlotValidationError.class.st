Class {
	#name : #LcsSlotValidationError,
	#superclass : #LcsSlotModelError,
	#instVars : [
		'value',
		'validationCondition',
		'slotDefinition'
	],
	#category : #'Lcs-SystemManagement-Tests'
}

{ #category : #'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue forCondition: anObject inSlot: aSlotDefinition [
	self new
		signalInvalidValue: aValue
		forCondition: anObject
		inSlot: aSlotDefinition
		context: nil
]

{ #category : #'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue forCondition: anObject inSlot: aSlotDefinition context: aDomainObject [
	self new
		signalInvalidValue: aValue
		forCondition: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
]

{ #category : #'gt view' }
LcsSlotValidationError >> gtExceptionContextView: aView [
	<gtView>
	<gtExceptionView>
	^aView columnedList
		title: 'Context';
		priority: 1;
		items: [ 
			{
				{'Value'. self value}.
				{'Description'. self validationCondition description}.
				{'Condition'. self validationCondition conditionBlock}.
			} ];
		column: 'Name'
			text: [ :each | each first asRopedText foreground: Color gray ]
			width: 100;
		column: 'Value' text: [ :each | each last gtDisplayString ]
]

{ #category : #'gt view' }
LcsSlotValidationError >> gtSlotDefinitionAttributes: aView [
	<gtView>
	<gtExceptionView>
	^aView forward
		title: 'Slot Attributes';
		priority: 2;
		object: [ self slotDefinition ];
		view: #gtSlotAttributesViewFor:
]

{ #category : #'instance creation' }
LcsSlotValidationError >> signalInvalidValue: aValue forCondition: aValidationCondition inSlot: aSlotDefinition context: aDomainObject [
	self value: aValue.
	self validationCondition: aValidationCondition.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self signal: self validationConditionErrorMessage
]

{ #category : #accessing }
LcsSlotValidationError >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsSlotValidationError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : #accessing }
LcsSlotValidationError >> validationCondition [
	^ validationCondition 
]

{ #category : #accessing }
LcsSlotValidationError >> validationCondition: aValidationCondition [ 
	validationCondition := aValidationCondition
]

{ #category : #'instance creation' }
LcsSlotValidationError >> validationConditionErrorMessage [
	^ self context class name asString , ' slot: ' , self slotDefinition slotName printString
		, ' has validation Error: ' , self validationCondition description printString
]

{ #category : #accessing }
LcsSlotValidationError >> value [
	^ value
]

{ #category : #accessing }
LcsSlotValidationError >> value: aValue [ 
	value := aValue
]
