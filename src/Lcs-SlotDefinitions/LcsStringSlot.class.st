Class {
	#name : #LcsStringSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialization }
LcsStringSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #configuration }
LcsStringSlot >> typeClass [
	^ LcsSmalltalkConfiguration stringClass
]
