Class {
	#name : 'LcsTableDefinition',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'caption',
		'columnDefinitions',
		'collectionSelector',
		'collectionFilter'
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
LcsTableDefinition class >> collectionFilterSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDomainObjectSlot new
		slotName: 'collectionFilter';
		addSlotType: LcsTableCollectionFilter;
		yourself
]

{ #category : 'slot definitions' }
LcsTableDefinition class >> collectionSelectorSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSymbolSlot new
		slotName: 'collectionSelector';
		initialValueBlock: [ :parentDomainObject :slot | #collection ];
		required: true;
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
LcsTableDefinition >> collectionFilter [
	^ self slotVarNamed: 'collectionFilter'
]

{ #category : 'accessing' }
LcsTableDefinition >> collectionFilter: anObject [
	self slotVarNamed: 'collectionFilter' put: anObject
]

{ #category : 'accessing' }
LcsTableDefinition >> collectionSelector [
	^ self slotVarNamed: 'collectionSelector'
]

{ #category : 'accessing' }
LcsTableDefinition >> collectionSelector: anObject [
	self slotVarNamed: 'collectionSelector' put: anObject
]

{ #category : 'accessing' }
LcsTableDefinition >> columnDefinitions [
	^ self slotVarNamed: 'columnDefinitions'
]

{ #category : 'accessing' }
LcsTableDefinition >> columnDefinitions: anObject [
	self slotVarNamed: 'columnDefinitions' put: anObject
]
