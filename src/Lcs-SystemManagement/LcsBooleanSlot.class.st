Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsBooleanSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | false ]
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
