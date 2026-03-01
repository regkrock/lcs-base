Class {
	#name : 'LcsDateSlotBuilder',
	#superclass : 'LcsSmalltalkObjectSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsDateSlotBuilder class >> slotClass [
	^ LcsDateSlot
]

{ #category : 'initialize' }
LcsDateSlotBuilder >> initialize [
	super initialize.
	self addSlotType: Date
]
