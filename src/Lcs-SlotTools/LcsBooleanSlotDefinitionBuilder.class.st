Class {
	#name : #LcsBooleanSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsBooleanSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsBooleanSlot
]

{ #category : #'code generation' }
LcsBooleanSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
