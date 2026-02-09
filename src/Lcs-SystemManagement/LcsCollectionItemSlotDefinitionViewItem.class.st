Class {
	#name : 'LcsCollectionItemSlotDefinitionViewItem',
	#superclass : 'LcsSlotDefinitionViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'private' }
LcsCollectionItemSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ aSlotCategory = #collectionItemSlotDefinition
]

{ #category : 'as yet unclassified' }
LcsCollectionItemSlotDefinitionViewItem >> setterSelector [
	^ self slotDefinition setterSelector
]
