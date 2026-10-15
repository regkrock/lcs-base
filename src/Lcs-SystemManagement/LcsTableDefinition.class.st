Class {
	#name : 'LcsTableDefinition',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'caption',
		'columnDefinitions',
		'collectionSelector',
		'collectionFilter',
		'domainCollectionSelector',
		'tableDefinitionName'
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
	^ LcsTableColumnDefinitionsSlotDefinition new
]

{ #category : 'slot definitions' }
LcsTableDefinition class >> domainCollectionSelectorSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSymbolSlot new
		slotName: 'domainCollectionSelector';
		addPostUpdateAction: (
				LcsUpdateAction new
					description: 'If table definition name is empty, make this the domain collection accessor the default name';
					actionBlock: [ :value :parentDomainObject :oldValue | 
						parentDomainObject updateTableDefinitionName: value ];
					yourself);
		yourself
]

{ #category : 'instance creation' }
LcsTableDefinition class >> newDefaultOn: aSlotDefinitionsCollection [
	^ self new
		initializeDefaultOn: aSlotDefinitionsCollection;
		yourself
]

{ #category : 'instance creation' }
LcsTableDefinition class >> newDefaultOnClass: aDomainObjectClass [
	^ self newDefaultOn: (aDomainObjectClass allSlotDefinitionsUpTo: aDomainObjectClass)
]

{ #category : 'instance creation' }
LcsTableDefinition class >> newForCollectionSlot: aDomainCollectionSlot [
	^ self new
		initializeForCollectionSlot: aDomainCollectionSlot;
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

{ #category : 'slot definitions' }
LcsTableDefinition class >> tableDefinitionNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'tableDefinitionName';
		required: true;
		yourself
]

{ #category : 'column definitions' }
LcsTableDefinition >> addColumnDefinitionFor: aSlotDefinition [
	| newColumn |
	newColumn := LcsTableColumnDefinition newOn: aSlotDefinition.
	newColumn parent: self.
	self columnDefinitions add: newColumn
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

{ #category : 'accessing' }
LcsTableDefinition >> domainCollectionSelector [
	^ self slotVarNamed: 'domainCollectionSelector'
]

{ #category : 'accessing' }
LcsTableDefinition >> domainCollectionSelector: anObject [
	self slotVarNamed: 'domainCollectionSelector' put: anObject
]

{ #category : 'elements' }
LcsTableDefinition >> elements [
	^ self collectionFilter evaluateOn: ((self parent parent perform: self domainCollectionSelector) perform: self collectionSelector)
]

{ #category : 'initialize' }
LcsTableDefinition >> initializeDefaultOn: aSlotDefinitionsCollection [ 
]

{ #category : 'initialize' }
LcsTableDefinition >> initializeFor: aDomainObjectClass  caption: aString [
	self caption: aString.
	aDomainObjectClass superclass == LcsDomainObject 
	ifTrue: [ aDomainObjectClass allSlotDefinitionsUpTo: aDomainObjectClass ]
	ifFalse: [ ]
]

{ #category : 'initialize' }
LcsTableDefinition >> initializeForCollectionSlot: aCollectionSlot [
	| domainObjectClass slotDefinitions|
	domainObjectClass := aCollectionSlot collectionMemberTypes first.
	self caption: aCollectionSlot slotTypes first defaultCollectionCaption.
	slotDefinitions := domainObjectClass allSlotDefinitionsUpTo: ( domainObjectClass immediateSubclassOfDomainObject).
	(slotDefinitions reject: [ :each | each slotName = 'parent']) do: [ :each | 
		self addColumnDefinitionFor: each ].
	self domainCollectionSelector: aCollectionSlot slotName asSymbol
]

{ #category : 'accessing' }
LcsTableDefinition >> tableDefinitionName [
	^ self slotVarNamed: 'tableDefinitionName'
]

{ #category : 'accessing' }
LcsTableDefinition >> tableDefinitionName: anObject [
	self slotVarNamed: 'tableDefinitionName' put: anObject
]

{ #category : 'updating' }
LcsTableDefinition >> updateTableDefinitionName: aString [
	aString isEmpty ifTrue: [ ^ self ].
	self tableDefinitionName notEmpty ifTrue: [ ^ self ].
	self tableDefinitionName: aString
]
