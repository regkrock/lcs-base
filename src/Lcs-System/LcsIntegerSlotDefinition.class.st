Class {
	#name : #LcsIntegerSlotDefinition,
	#superclass : #LcsNumberSlotDefinition,
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsIntegerSlotDefinition >> typeClass [
	^LcsSmalltalkConfiguration integerClass
]
