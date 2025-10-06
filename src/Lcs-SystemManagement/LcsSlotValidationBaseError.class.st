Class {
	#name : #LcsSlotValidationBaseError,
	#superclass : #LcsSlotModelError,
	#instVars : [
		'slotDefinition',
		'validationCondition',
		'value',
		'oldValue'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'gt view' }
LcsSlotValidationBaseError >> gtExceptionContextView: aView [
	<gtView>
	<gtExceptionView>
	^aView columnedList
		title: 'Context';
		priority: 1;
		items: [ 
			{
				{'System'. self currentSystem class}.
				{'Domain Class'. self slotDefinition domainClass}.
				{'Slot name'. self slotDefinition slotName}.
				{''. ''}.
				{'Value'. self value}.
				{'Old Value'. self oldValue}.
				{'Domain Object'. self context}.
				{''. ''}.
				{'Description'. self validationCondition validationDescription}.
				{'Condition'. self validationCondition conditionBlock}.
			} ];
		column: 'Name'
			text: [ :each | each first asRopedText foreground: Color gray ]
			width: 100;
		column: 'Value' text: [ :each | each last gtDisplayString ];
		send: #last
]

{ #category : #'gt view' }
LcsSlotValidationBaseError >> gtSlotDefinitionAttributes: aView [
	<gtView>
	<gtExceptionView>
	^aView forward
		title: 'Slot Attributes';
		priority: 2;
		object: [ self slotDefinition ];
		view: #gtSlotAttributesViewFor:
]

{ #category : #accessing }
LcsSlotValidationBaseError >> oldValue [
	^ oldValue
]

{ #category : #accessing }
LcsSlotValidationBaseError >> oldValue: anObject [
	oldValue := anObject
]

{ #category : #accessing }
LcsSlotValidationBaseError >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsSlotValidationBaseError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : #accessing }
LcsSlotValidationBaseError >> validationCondition [
	^ validationCondition 
]

{ #category : #accessing }
LcsSlotValidationBaseError >> validationCondition: aValidationCondition [ 
	validationCondition := aValidationCondition
]

{ #category : #accessing }
LcsSlotValidationBaseError >> value [
	^ value
]

{ #category : #accessing }
LcsSlotValidationBaseError >> value: aValue [ 
	value := aValue
]
