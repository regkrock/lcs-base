Class {
	#name : #LcsSingletonCodeIsDefaultInstanceSlot,
	#superclass : #LcsBooleanSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonCodeIsDefaultInstanceSlot >> initialize [
	super initialize.
	self slotName: 'isDefaultInstance'.
	self initialValueBlock: [ :anInstance | anInstance class defaultInstance ]
]
