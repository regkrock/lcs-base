Class {
	#name : #LcsSlotValidationBaseError,
	#superclass : #LcsSlotModelError,
	#instVars : [
		'slotDefinition',
		'validationCondition',
		'value'
	],
	#category : #'Lcs-SystemManagement-Tests'
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
				{'Value'. self value}.
				{'Description'. self validationCondition validationDescription}.
				{'Condition'. self validationCondition conditionBlock}.
			} ];
		column: 'Name'
			text: [ :each | each first asRopedText foreground: Color gray ]
			width: 100;
		column: 'Value' text: [ :each | each last gtDisplayString ]
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
