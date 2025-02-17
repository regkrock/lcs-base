Class {
	#name : #LcsNumberSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ 0 ]
]

{ #category : #defaults }
LcsNumberSlot >> typeClass [
	^ Number
]
