Class {
	#name : #LcsIntegerSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsIntegerSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsIntegerSlot
]

{ #category : #'code generation' }
LcsIntegerSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
