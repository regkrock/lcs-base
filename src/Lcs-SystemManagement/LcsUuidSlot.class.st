Class {
	#name : #LcsUuidSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsUuidSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | parentDomainObject currentSystem uuidGenerator next asInteger  ]
]

{ #category : #defaults }
LcsUuidSlot >> initialize [
	super initialize.
	self 
		slotName: 'uuid';
		priority: 100
]

{ #category : #configuration }
LcsUuidSlot >> typeClass [
	^ Integer
]
