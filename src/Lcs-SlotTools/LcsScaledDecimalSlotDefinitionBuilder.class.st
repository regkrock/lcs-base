Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsScaledDecimalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsScaledDecimalSlot
]

{ #category : #'code generation' }
LcsScaledDecimalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
