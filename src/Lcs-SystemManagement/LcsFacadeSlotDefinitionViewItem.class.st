Class {
	#name : 'LcsFacadeSlotDefinitionViewItem',
	#superclass : 'LcsSlotDefinitionViewItem',
	#category : 'Lcs-SystemManagement-Core',
	#package : 'Lcs-SystemManagement',
	#tag : 'Core'
}

{ #category : 'private' }
LcsFacadeSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ aSlotCategory = #facadeSlotDefinition
]

{ #category : 'as yet unclassified' }
LcsFacadeSlotDefinitionViewItem >> setterSelector [
	^ self slotDefinition setterSelector
]
