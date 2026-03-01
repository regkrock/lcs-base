Class {
	#name : 'LcsSlotValidationBaseError',
	#superclass : 'LcsSlotModelError',
	#instVars : [
		'slotDefinition',
		'validationCondition',
		'value',
		'oldValue'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'gt view' }
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
				{'Error Description'. self validationCondition validationDescription}.
				{'Error Condition'. self validationCondition conditionBlock}.
				{''. ''}.
				{'Validation Conditions'. self validationCondition parent}
			} ];
		"children: [ :each | each class == LcsValidationCondition ifTrue: [ each conditions collect: [ :e | {''. e} ] ] ifFalse: [ #() ] ]"
		column: 'Name'
			text: [ :each | each first asRopedText foreground: Color gray ]
			width: 120;
		column: 'Value' text: [ :each | each last ];
		send: #last
]

{ #category : 'gt view' }
LcsSlotValidationBaseError >> gtSlotPropertiesView: aView [
	<gtView>
	<gtExceptionView>
	^aView forward
		title: 'Slot Properties';
		priority: 2;
		object: [ self slotDefinition ];
		view: #gtSlotPropertiesViewFor:
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> oldValue [
	^ oldValue
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> oldValue: anObject [
	oldValue := anObject
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> slotDefinition [
	^ slotDefinition
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> validationCondition [
	^ validationCondition 
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> validationCondition: aValidationCondition [ 
	validationCondition := aValidationCondition
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> value [
	^ value
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> value: aValue [ 
	value := aValue
]
