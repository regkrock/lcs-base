Class {
	#name : #LcsDateSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsDateSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
