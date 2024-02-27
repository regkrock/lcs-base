Class {
	#name : #LcsBooleanSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsBooleanSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
