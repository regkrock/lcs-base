Class {
	#name : #LcsStateMachineSlot,
	#superclass : #LcsCompositeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'instance creation' }
LcsStateMachineSlot class >> newOn: aStateMachineClass [
	^ self new
		initializeOn: aStateMachineClass
		yourself
]

{ #category : #initialize }
LcsStateMachineSlot >> initialize [
	super initialize.
	self slotName: 'status'
]

{ #category : #initialize }
LcsStateMachineSlot >> initializeOn: aStateMachineClass [ 
	self addSlotType: aStateMachineClass
]
