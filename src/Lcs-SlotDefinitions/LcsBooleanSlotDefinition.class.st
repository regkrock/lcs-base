Class {
	#name : #LcsBooleanSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsBooleanSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
