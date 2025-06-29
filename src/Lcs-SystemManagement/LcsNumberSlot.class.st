Class {
	#name : #LcsNumberSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ 0 ]
]

{ #category : #'as yet unclassified' }
LcsNumberSlot >> isNullObject: anObject [ 
	^ anObject isZero
]

{ #category : #defaults }
LcsNumberSlot >> typeClass [
	^ Number
]
