Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsBooleanSlot >> defaultInitialValue [ 
	^ false
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
