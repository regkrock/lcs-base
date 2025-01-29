Class {
	#name : #LcsDomainObjectSlotChange,
	#superclass : #LcsDomainObject,
	#classInstVars : [
		'slotName',
		'oldValue',
		'newValue'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #accessing }
LcsDomainObjectSlotChange class >> newValue [
	^ newValue
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> newValue: anObject [
	newValue := anObject
]

{ #category : #'slot definition' }
LcsDomainObjectSlotChange class >> newValueSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'newValue';
		yourself
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> oldValue [
	^ oldValue
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> oldValue: anObject [
	oldValue := anObject
]

{ #category : #'slot definition' }
LcsDomainObjectSlotChange class >> oldValueSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'oldValue';
		yourself
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> slotName: anObject [
	slotName := anObject
]

{ #category : #'slot definition' }
LcsDomainObjectSlotChange class >> slotNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		yourself
]
