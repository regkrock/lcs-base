Class {
	#name : #LcsNumberSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ 0 ]
]

{ #category : #default }
LcsNumberSlot >> typeClass [
	^ Number
]
