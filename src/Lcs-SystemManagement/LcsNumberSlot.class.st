Class {
	#name : #LcsNumberSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ :domainObject :slot | 0 ]
]

{ #category : #defaults }
LcsNumberSlot >> typeClass [
	^ Number
]
