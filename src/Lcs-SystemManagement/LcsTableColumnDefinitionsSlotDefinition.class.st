Class {
	#name : 'LcsTableColumnDefinitionsSlotDefinition',
	#superclass : 'LcsLocalCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsTableColumnDefinitionsSlotDefinition >> initialize [
	super initialize.
	self
		slotName: 'columnDefinitions';
		addSlotType: LcsTableColumnDefinitions;
		collectionClass: OrderedCollection;
		addCollectionMemberType: LcsTableColumnDefinition;
		comment: 'This  defines the coumns that will be part of the report'
]
