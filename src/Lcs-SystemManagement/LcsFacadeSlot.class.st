"
This slot that encapsulates another slot. The actual slot can be updated by delegating the slot access to the encapsulated slot.

For example, if a slot of userId exists, the userId slot will take a string as input and return a string as output.

If one wants to access the user object, then a user slot can be created which encapsulates the userId. The user slot would contain the behaviour to take the userId and do the approprite lookups to return a user. Likewise, when setting a user the user slot definition would get the userId and pass it to the userId slot defintion for persisting.

For performance, the facade slot can cache the retrieved object. In the user example, the user slot would cache the retrieved user. Care must be taken to ensure the userId slot and the user slot are not allowed to become unsynced.
"
Class {
	#name : #LcsFacadeSlot,
	#superclass : #LcsAccessorSlot,
	#instVars : [
		'targetSlotName',
		'convertFromTarget',
		'convertToTarget'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsFacadeSlot >> convertFromTarget [
	^ convertFromTarget
]

{ #category : #accessing }
LcsFacadeSlot >> convertFromTarget: anObject [
	convertFromTarget := anObject
]

{ #category : #accessing }
LcsFacadeSlot >> convertToTarget [
	^ convertToTarget
]

{ #category : #accessing }
LcsFacadeSlot >> convertToTarget: anObject [
	convertToTarget := anObject
]

{ #category : #'as yet unclassified' }
LcsFacadeSlot >> currentSlotVarIn: aDomainObject [
	^ self convertFromTarget 
		cull: (aDomainObject slotVarNamed: self targetSlotName) 
		cull: aDomainObject
]

{ #category : #'slot access' }
LcsFacadeSlot >> slotVarPut: anObject in: aTargetDomainObject [
	aTargetDomainObject
		slotVarNamed: self targetSlotName
		put: (self convertToTarget cull: anObject  cull: aTargetDomainObject)
]

{ #category : #accessing }
LcsFacadeSlot >> targetSlotName [
	^ targetSlotName
]

{ #category : #accessing }
LcsFacadeSlot >> targetSlotName: anObject [
	targetSlotName := anObject
]
