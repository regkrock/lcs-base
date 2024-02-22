Class {
	#name : #LcsBooleanSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsBooleanSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
