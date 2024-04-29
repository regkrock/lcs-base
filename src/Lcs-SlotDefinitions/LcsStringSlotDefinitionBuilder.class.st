Class {
	#name : #LcsStringSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsStringSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsStringSlot
]

{ #category : #'code generation' }
LcsStringSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
