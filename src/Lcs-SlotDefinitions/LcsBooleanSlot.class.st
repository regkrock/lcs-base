Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #accessing }
LcsBooleanSlot >> defaultInitialValueBlock [ 
	^ [ false ]
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
