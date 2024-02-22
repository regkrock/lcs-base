Class {
	#name : #LcsDateSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsDateSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
