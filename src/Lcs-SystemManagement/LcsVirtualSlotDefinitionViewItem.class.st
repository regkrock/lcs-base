Class {
	#name : 'LcsVirtualSlotDefinitionViewItem',
	#superclass : 'LcsSlotDefinitionViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'private' }
LcsVirtualSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ aSlotCategory = #virtualSlotDefinition
]

{ #category : 'as yet unclassified' }
LcsVirtualSlotDefinitionViewItem >> setterSelector [
	^ ''
]
