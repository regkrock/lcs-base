Class {
	#name : #LcsStateMachineSlot,
	#superclass : #LcsCompositeSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'instance creation' }
LcsStateMachineSlot class >> newOn: aStateMachineClass [
	^ self new
		initializeOn: aStateMachineClass
		yourself
]

{ #category : #accessing }
LcsStateMachineSlot >> initialize [
	super initialize.
	self slotName: 'status'
]

{ #category : #accessing }
LcsStateMachineSlot >> initializeOn: aStateMachineClass [ 
	self addSlotType: aStateMachineClass
]
