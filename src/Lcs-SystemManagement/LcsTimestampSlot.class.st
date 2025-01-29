Class {
	#name : #LcsTimestampSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #defaults }
LcsTimestampSlot >> defaultInitialValueBlock [
	^ [ self typeClass now ]
]

{ #category : #defaults }
LcsTimestampSlot >> initialize [
	super initialize.
	self slotName: 'timestamp'
]

{ #category : #default }
LcsTimestampSlot >> typeClass [
	^ DateAndTime 
]
