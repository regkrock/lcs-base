Class {
	#name : 'LcsFacadeSlotDefinitionViewItem',
	#superclass : 'LcsSlotDefinitionViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'private' }
LcsFacadeSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ aSlotCategory = LcsBaseSlot facadeSlotDefinitionName
]

{ #category : 'as yet unclassified' }
LcsFacadeSlotDefinitionViewItem >> setterSelector [
	^ self slotDefinition setterSelector
]
