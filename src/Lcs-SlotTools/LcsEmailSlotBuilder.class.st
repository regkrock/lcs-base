Class {
	#name : 'LcsEmailSlotBuilder',
	#superclass : 'LcsSmalltalkObjectSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsEmailSlotBuilder class >> slotClass [
	^ LcsEmailSlot
]

{ #category : 'initialize' }
LcsEmailSlotBuilder >> initialize [
	super initialize.
	self addSlotType: String
]
