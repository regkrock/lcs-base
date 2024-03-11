Class {
	#name : #LcsIntegerSlotDefinition,
	#superclass : #LcsNumberSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsIntegerSlotDefinition >> typeClass [
	^LcsSmalltalkConfiguration integerClass
]
