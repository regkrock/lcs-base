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

{ #category : #'slot definitions' }
LcsDomainObjectSlotChange class >> newValueSlotDefinition [
	<slotDefinition>
	^  LcsValueHistorySlot new
		slotName: 'newValue';
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectSlotChange class >> oldValueSlotDefinition [
	<slotDefinition>
	^ LcsValueHistorySlot new
		slotName: 'oldValue';
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectSlotChange class >> slotNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		makeDirectVariableUpdate;
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
