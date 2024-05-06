Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsBooleanSlot >> newSlotValue [
	^ false
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
