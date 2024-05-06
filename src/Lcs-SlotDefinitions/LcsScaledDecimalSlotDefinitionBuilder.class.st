Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsScaledDecimalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsScaledDecimalSlot
]

{ #category : #'code generation' }
LcsScaledDecimalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
