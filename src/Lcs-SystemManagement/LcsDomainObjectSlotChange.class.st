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

{ #category : #accessing }
LcsDomainObjectSlotChange class >> oldValue [
	^ oldValue
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> oldValue: anObject [
	oldValue := anObject
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsDomainObjectSlotChange class >> slotName: anObject [
	slotName := anObject
]
