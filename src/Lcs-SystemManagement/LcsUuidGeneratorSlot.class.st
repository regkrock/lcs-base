Class {
	#name : 'LcsUuidGeneratorSlot',
	#superclass : 'LcsSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsUuidGeneratorSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | slot typeClass basicNew initialize ]
]

{ #category : 'defaults' }
LcsUuidGeneratorSlot >> initialize [
	super initialize.
	self slotName: 'uuidGenerator'
]

{ #category : 'initialize' }
LcsUuidGeneratorSlot >> typeClass [
	^ UUIDGenerator
]
