Class {
	#name : 'LcsSmalltalkObjectSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSmalltalkObjectSlot >> addDefaultSlotType [
	"No default"
	^ self
]

{ #category : 'defaults' }
LcsSmalltalkObjectSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | slot slotTypes isEmpty ifTrue: [ nil ] ifFalse: [ slot slotTypes first new ] ]
]
