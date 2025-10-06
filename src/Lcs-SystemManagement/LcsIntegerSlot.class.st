Class {
	#name : #LcsIntegerSlot,
	#superclass : #LcsNumberSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #testing }
LcsIntegerSlot >> isNullObject: anObject [ 
	^ anObject isZero
]

{ #category : #configuration }
LcsIntegerSlot >> typeClass [
	^LcsSmalltalkConfiguration integerClass
]
