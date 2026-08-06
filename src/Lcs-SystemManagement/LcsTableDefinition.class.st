Class {
	#name : 'LcsTableDefinition',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'caption',
		'columnDefinitions'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableDefinition class >> captionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'caption';
		yourself
]

{ #category : 'slot definitions' }
LcsTableDefinition class >> columnDefinitionsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDomainCollectionSlot new
		slotName: 'columnDefinitions';
		addSlotType: LcsTableColumnDefinition;
		comment: 'This  defines the coumns that will be part of the report';
		collectionClass: OrderedCollection;
		yourself
]

{ #category : 'slot definitions' }
LcsTableDefinition class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionReferenceSlot new
		addSlotType: LcsTableDefinitions;
		slotName: 'parent';
		collectionSlotName: 'tableDefinitions';
		yourself
]

{ #category : 'accessing' }
LcsTableDefinition >> caption [
	^ self slotVarNamed: 'caption'
]

{ #category : 'accessing' }
LcsTableDefinition >> caption: anObject [
	self slotVarNamed: 'caption' put: anObject
]

{ #category : 'accessing' }
LcsTableDefinition >> columnDefinitions [
	^ self slotVarNamed: 'columnDefinitions'
]

{ #category : 'accessing' }
LcsTableDefinition >> columnDefinitions: anObject [
	self slotVarNamed: 'columnDefinitions' put: anObject
]
