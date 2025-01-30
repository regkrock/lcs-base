Class {
	#name : #LcsDateSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsDateSlot >> defaultInitialValueBlock [ 
	^ [ Date today ]
]

{ #category : #configuration }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
