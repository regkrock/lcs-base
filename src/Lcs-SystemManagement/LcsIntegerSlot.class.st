Class {
	#name : 'LcsIntegerSlot',
	#superclass : 'LcsNumberSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsIntegerSlot >> defaultStepValue [
	^ 1
]

{ #category : 'testing' }
LcsIntegerSlot >> isNullObject: anObject [ 
	^ anObject isZero
]

{ #category : 'configuration' }
LcsIntegerSlot >> typeClass [
	^LcsSmalltalkConfiguration integerClass
]
