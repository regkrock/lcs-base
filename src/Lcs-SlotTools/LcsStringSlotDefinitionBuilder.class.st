Class {
	#name : #LcsStringSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsStringSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsStringSlot
]

{ #category : #'code generation' }
LcsStringSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
