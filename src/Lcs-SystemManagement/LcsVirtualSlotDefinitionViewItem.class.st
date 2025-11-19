Class {
	#name : 'LcsVirtualSlotDefinitionViewItem',
	#superclass : 'LcsSlotDefinitionViewItem',
	#category : 'Lcs-SystemManagement-Core',
	#package : 'Lcs-SystemManagement',
	#tag : 'Core'
}

{ #category : 'private' }
LcsVirtualSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ aSlotCategory = #virtualSlotDefinition
]

{ #category : 'as yet unclassified' }
LcsVirtualSlotDefinitionViewItem >> setterSelector [
	^ ''
]
