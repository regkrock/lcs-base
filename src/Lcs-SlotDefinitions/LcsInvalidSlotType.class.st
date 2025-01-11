Class {
	#name : #LcsInvalidSlotType,
	#superclass : #LcsError,
	#instVars : [
		'object',
		'slotDefinition'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'instance  creation' }
LcsInvalidSlotType class >> newInvalidParentTypeObject: anObject forSlot: aSlotDefinition [
	self new
		object: anObject;
		slotDefinition: aSlotDefinition;
		signal: 'Attempt to update ' , aSlotDefinition slotName , '  slot("' , aSlotDefinition class name , '") with an invalid type - ' , anObject printString
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain';
		priority: 20;
		object: [ slotDefinition domainClass ];
		view: #gtMetaFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtRawSlotDefinitionViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Definition(Raw)';
		priority: 11;
		object: [ slotDefinition ];
		view: #gtRawFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtSlotAttributesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Attributes';
		priority: 11;
		object: [ slotDefinition ];
		view: #gtSlotDefinitionViewFor:
]

{ #category : #'gt view' }
LcsInvalidSlotType >> gtSlotTypesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Types';
		priority: 10;
		object: [ slotDefinition ];
		view: #gtSlotTypesViewFor:
]

{ #category : #accessing }
LcsInvalidSlotType >> object [
	^ object
]

{ #category : #accessing }
LcsInvalidSlotType >> object: anObject [ 
	object := anObject
]

{ #category : #accessing }
LcsInvalidSlotType >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsInvalidSlotType >> slotDefinition: aSlotDefinition [ 
	slotDefinition := aSlotDefinition
]
