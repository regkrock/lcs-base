Class {
	#name : 'LcsObjectVersionSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsObjectVersionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | 0 ]
]

{ #category : 'defaults' }
LcsObjectVersionSlot >> initialize [
	super initialize.
	self slotName: 'version'
]

{ #category : 'initialize' }
LcsObjectVersionSlot >> typeClass [
	^ SmallInteger
]
