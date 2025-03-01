Class {
	#name : #LcsInvalidSlotType,
	#superclass : #LcsError,
	#instVars : [
		'object',
		'slotDefinition',
		'target'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance  creation' }
LcsInvalidSlotType class >> signalInvalidType: anObject forSlot: aSlotDefinition for: aDomainObject [
	self new
		signalInvalidType: anObject
		forSlot: aSlotDefinition
		for: aDomainObject
]

{ #category : #signal }
LcsInvalidSlotType >> domainClassName [
	^ self slotDefinition domainClass name
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtSlotAttributesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Attributes';
		priority: 11;
		object: [ self slotDefinition ];
		view: #gtSlotAttributesViewFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtSlotDefinitionViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Definition';
		priority: 12;
		object: [ self slotDefinition ];
		view: #gtViewsFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtSlotTypesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Valid Slot Types';
		priority: 10;
		object: [ slotDefinition ];
		view: #gtSlotTypesViewFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtTargetSlotModelViewsFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Target Slot Model';
		priority: 21;
		object: [ self target slotModel ];
		view: #gtViewsFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtTargetViewsFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Target';
		priority: 20;
		object: [ self target ];
		view: #gtViewsFor:
]

{ #category : #signal }
LcsInvalidSlotType >> invalidSlotTypeMessage [
	^ 'Attempt to update ' , self slotName printString , '  slot("'
		, self slotDefinition class name , '") in '
		, self slotDefinition domainClass name , ' with: ' , self object printString
]

{ #category : #accessing }
LcsInvalidSlotType >> object [
	^ object
]

{ #category : #accessing }
LcsInvalidSlotType >> object: anObject [ 
	object := anObject
]

{ #category : #signal }
LcsInvalidSlotType >> signalInvalidType: anObject forSlot: aSlotDefinition for: aDomainObject [
	self object: anObject.
	self slotDefinition: aSlotDefinition.
	self target: aDomainObject.
	self signal: self invalidSlotTypeMessage
]

{ #category : #accessing }
LcsInvalidSlotType >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsInvalidSlotType >> slotDefinition: aSlotDefinition [ 
	slotDefinition := aSlotDefinition
]

{ #category : #signal }
LcsInvalidSlotType >> slotDefinitionClassName [
	^ self slotDefinition class name
]

{ #category : #signal }
LcsInvalidSlotType >> slotName [
	^ self slotDefinition slotName
]

{ #category : #accessing }
LcsInvalidSlotType >> target [
	^ target
]

{ #category : #signal }
LcsInvalidSlotType >> target: aDomainObject [ 
	target := aDomainObject
]
