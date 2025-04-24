Class {
	#name : #LcsSingletonCodeNameSlot,
	#superclass : #LcsCodeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonCodeNameSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :anInstance | anInstance class defaultCode ]
]
