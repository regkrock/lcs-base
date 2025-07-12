Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsBooleanSlot >> defaultInitialValueBlock [ 
	^ [ :domainObject :slot | false ]
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
