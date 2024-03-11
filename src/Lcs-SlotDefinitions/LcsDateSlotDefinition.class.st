Class {
	#name : #LcsDateSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsDateSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
