Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsBooleanSlot >> defaultInitialValueBlock [ 
	^ [ false ]
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
