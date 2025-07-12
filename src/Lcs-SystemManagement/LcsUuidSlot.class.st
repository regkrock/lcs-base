Class {
	#name : #LcsUuidSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsUuidSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | domainObject currentSystem uuidGenerator next asInteger  ]
]

{ #category : #defaults }
LcsUuidSlot >> initialize [
	super initialize.
	self slotName: 'uuid'
]

{ #category : #configuration }
LcsUuidSlot >> typeClass [
	^ Integer
]
