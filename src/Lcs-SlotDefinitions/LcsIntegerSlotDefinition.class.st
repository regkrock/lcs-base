Class {
	#name : #LcsIntegerSlotDefinition,
	#superclass : #LcsNumberSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsIntegerSlotDefinition >> typeClass [
	^LcsSmalltalkConfiguration integerClass
]
