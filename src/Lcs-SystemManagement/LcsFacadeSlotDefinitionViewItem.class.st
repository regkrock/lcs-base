Class {
	#name : #LcsFacadeSlotDefinitionViewItem,
	#superclass : #LcsSlotDefinitionViewItem,
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #private }
LcsFacadeSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ aSlotCategory = #facadeSlotDefinition
]

{ #category : #'as yet unclassified' }
LcsFacadeSlotDefinitionViewItem >> setterSelector [
	^ self slotDefinition setterSelector
]
