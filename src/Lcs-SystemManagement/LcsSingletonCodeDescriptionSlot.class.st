Class {
	#name : #LcsSingletonCodeDescriptionSlot,
	#superclass : #LcsDescriptionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonCodeDescriptionSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :anInstance | anInstance class defaultDescription ]
]
