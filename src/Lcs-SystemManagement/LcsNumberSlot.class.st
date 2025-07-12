Class {
	#name : #LcsNumberSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ :domainObject :slot | 0 ]
]

{ #category : #testing }
LcsNumberSlot >> isNullObject: anObject [ 
	^ anObject isZero
]

{ #category : #defaults }
LcsNumberSlot >> typeClass [
	^ Number
]
