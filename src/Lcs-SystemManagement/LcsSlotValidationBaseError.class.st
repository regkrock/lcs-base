Class {
	#name : 'LcsSlotValidationBaseError',
	#superclass : 'LcsSlotDefinitionError',
	#instVars : [
		'slotDefinition',
		'value',
		'oldValue',
		'rule'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'slot model' }
LcsSlotValidationBaseError >> domainClass [
	^ self slotDefinition ifNil: [ '<nil>' ] ifNotNil: [ :slot | slot ifNotNil: [ slot domainClass ] ]
]

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
				{'Domain Class'. self domainClass}.
				{'Slot name'. self slotName}.
				{''. ''}.
				{'Value'. self value}.
				{'Old Value'. self oldValue}.
				{'Domain Object'. self context}.
				{'Original Exception'. self smalltalkException}.
				{''. ''}.
				{'Error Description'. self rule description}.
				{'Error Condition'. self rule conditionBlock}.
				{''. ''}.
				{'Validation Conditions'. }
			} ];
		"children: [ :each | each class == LcsValidationCondition ifTrue: [ each conditions collect: [ :e | {''. e} ] ] ifFalse: [ #() ] ]"
		column: 'Name'
			text: [ :each | each first asRopedText foreground: Color gray ]
			width: 120;
		column: 'Value' text: [ :each | each last ];
		send: #last
]

{ #category : 'gt view' }
LcsSlotValidationBaseError >> gtSlotDefinitionMethodFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView explicit
		title: 'Slot Defn';
		tooltip: 'Method that defines the slot';
		priority: 19;
		stencil: [ self slotDefinition slotDefinitionMethodsFilter ];
		actionUpdateButton
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
LcsSlotValidationBaseError >> rule [
	^ rule 
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> rule: aRule [ 
	rule := aRule
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> slotDefinition [
	^ slotDefinition
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : 'slot model' }
LcsSlotValidationBaseError >> slotName [
	^ self slotDefinition ifNil: [ '<nil>' ] ifNotNil: [ :slot | slot slotName ]
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> value [
	^ value
]

{ #category : 'accessing' }
LcsSlotValidationBaseError >> value: aValue [ 
	value := aValue
]
