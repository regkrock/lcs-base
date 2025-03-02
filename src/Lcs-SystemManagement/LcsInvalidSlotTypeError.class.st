Class {
	#name : #LcsInvalidSlotTypeError,
	#superclass : #LcsError,
	#instVars : [
		'object',
		'slotDefinition',
		'target'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance  creation' }
LcsInvalidSlotTypeError class >> signalInvalidType: anObject forSlot: aSlotDefinition for: aDomainObject [
	self new
		signalInvalidType: anObject
		forSlot: aSlotDefinition
		for: aDomainObject
]

{ #category : #signal }
LcsInvalidSlotTypeError >> domainClassName [
	^ self slotDefinition domainClass name
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtSlotAttributesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Attributes';
		priority: 15;
		object: [ self slotDefinition ];
		view: #gtSlotAttributesViewFor:
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtSlotDefinitionViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Definition';
		priority: 18;
		object: [ self slotDefinition ];
		view: #gtViewsFor:
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtSlotTypesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Valid Slot Types';
		priority: 10;
		object: [ slotDefinition ];
		view: #gtSlotTypesViewFor:
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtTargetSlotModelViewsFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Target Slot Model';
		priority: 21;
		object: [ self target slotModel ];
		view: #gtViewsFor:
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtTargetViewsFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Target';
		priority: 20;
		object: [ self target ];
		view: #gtViewsFor:
]

{ #category : #signal }
LcsInvalidSlotTypeError >> invalidSlotTypeMessage [
	^ 'Attempt to update ' , self slotName printString , '  slot("'
		, self slotDefinition class name , '") in '
		, self slotDefinition domainClass name , ' with: ' , self object printString
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> object [
	^ object
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> object: anObject [ 
	object := anObject
]

{ #category : #signal }
LcsInvalidSlotTypeError >> signalInvalidType: anObject forSlot: aSlotDefinition for: aDomainObject [
	self object: anObject.
	self slotDefinition: aSlotDefinition.
	self target: aDomainObject.
	self signal: (self messageText: self invalidSlotTypeMessage)
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> slotDefinition: aSlotDefinition [ 
	slotDefinition := aSlotDefinition
]

{ #category : #signal }
LcsInvalidSlotTypeError >> slotDefinitionClassName [
	^ self slotDefinition class name
]

{ #category : #signal }
LcsInvalidSlotTypeError >> slotName [
	^ self slotDefinition slotName
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> target [
	^ target
]

{ #category : #signal }
LcsInvalidSlotTypeError >> target: aDomainObject [ 
	target := aDomainObject
]
