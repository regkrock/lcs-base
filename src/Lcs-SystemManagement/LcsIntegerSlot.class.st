Class {
	#name : #LcsIntegerSlot,
	#superclass : #LcsNumberSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #configuration }
LcsIntegerSlot >> typeClass [
	^LcsSmalltalkConfiguration integerClass
]
