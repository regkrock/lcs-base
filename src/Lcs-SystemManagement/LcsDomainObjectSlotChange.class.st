Class {
	#name : #LcsDomainObjectSlotChange,
	#superclass : #LcsSupportDomainObject,
	#instVars : [
		'slotName',
		'oldValue',
		'newValue'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'application environment' }
LcsDomainObjectSlotChange class >> addToUnitOfWork: newObject [
	"this is not saved in the Unit of Work as it is part of the unit of work"
]

{ #category : #'slot definitions' }
LcsDomainObjectSlotChange class >> newValueSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'newValue';
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectSlotChange class >> oldValueSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'oldValue';
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectSlotChange class >> slotNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		yourself
]

{ #category : #accessing }
LcsDomainObjectSlotChange >> newValue [
	^ self slotVarNamed: 'newValue'
]

{ #category : #accessing }
LcsDomainObjectSlotChange >> newValue: anObject [
	self slotVarNamed: 'newValue' put: anObject
]

{ #category : #accessing }
LcsDomainObjectSlotChange >> oldValue [
	^ self slotVarNamed: 'oldValue'
]

{ #category : #accessing }
LcsDomainObjectSlotChange >> oldValue: anObject [
	self slotVarNamed: 'oldValue' put: anObject
]

{ #category : #accessing }
LcsDomainObjectSlotChange >> slotName [
	^ self slotVarNamed: 'slotName'
]

{ #category : #accessing }
LcsDomainObjectSlotChange >> slotName: anObject [
	self slotVarNamed: 'slotName' put: anObject
]
