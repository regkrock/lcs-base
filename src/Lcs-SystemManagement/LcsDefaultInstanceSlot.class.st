Class {
	#name : #LcsDefaultInstanceSlot,
	#superclass : #LcsVirtualSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsDefaultInstanceSlot >> defaultValueAccessBlock [
	[ :domainCollection | domainCollection defaultInstance ]
]

{ #category : #inititalize }
LcsDefaultInstanceSlot >> initialize [
	super initialize.
	self slotName: 'defaultInstance'
]
