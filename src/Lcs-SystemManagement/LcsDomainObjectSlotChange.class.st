Class {
	#name : #LcsDomainObjectSlotChange,
	#superclass : #LcsDomainObject,
	#instVars : [
		'slotName',
		'oldValue',
		'newValue'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definition' }
LcsDomainObjectSlotChange class >> newValueSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'newValue';
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectSlotChange class >> oldValueSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'oldValue';
		yourself
]

{ #category : #'slot definition' }
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
