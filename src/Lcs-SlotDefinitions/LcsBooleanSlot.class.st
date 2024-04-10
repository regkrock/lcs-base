Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
