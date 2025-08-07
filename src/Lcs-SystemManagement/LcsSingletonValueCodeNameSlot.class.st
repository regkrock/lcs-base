Class {
	#name : #LcsSingletonValueCodeNameSlot,
	#superclass : #LcsValueCodeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonValueCodeNameSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :anInstance | anInstance class defaultCode ]
]
