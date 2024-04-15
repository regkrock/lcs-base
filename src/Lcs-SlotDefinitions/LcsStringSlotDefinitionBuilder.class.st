Class {
	#name : #LcsStringSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsStringSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsStringSlot
]

{ #category : #api }
LcsStringSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
