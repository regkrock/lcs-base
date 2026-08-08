Class {
	#name : 'LcsBaseDomainCollection',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'caption',
		'tableDefinitions'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsBaseDomainCollection class >> captionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'caption';
		initialValueBlock: [ :parentDomainObject :slot | parentDomainObject defaultCollectionCaption ];
		yourself
]

{ #category : 'defaults' }
LcsBaseDomainCollection class >> defaultCollectionCaption [
	^ (self name copyFrom: 4 to: self name size) asCapitalizedPhrase
]

{ #category : 'slot definitions' }
LcsBaseDomainCollection class >> tableDefinitionsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'tableDefinitions';
		addSlotType: LcsTableDefinitions;
		addCollectionMemberType: LcsTableDefinition;
		yourself
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> caption [
	^ self slotVarNamed: 'caption'
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> caption: anObject [
	self slotVarNamed: 'caption' put: anObject
]

{ #category : 'querrying' }
LcsBaseDomainCollection >> collectionType [
	^ self class collectionType
]

{ #category : 'defaults' }
LcsBaseDomainCollection >> defaultCollectionCaption [
	^ self class defaultCollectionCaption
]

{ #category : 'querying' }
LcsBaseDomainCollection >> find: aBlock [
	^ self find: aBlock ifNone: [ nil ]
]

{ #category : 'querying' }
LcsBaseDomainCollection >> findWithKey: anObject [
	^ self findWithKey: anObject ifNone: [ ]
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> tableDefinitions [
	^ self slotVarNamed: 'tableDefinitions'
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> tableDefinitions: anObject [
	self slotVarNamed: 'tableDefinitions' put: anObject
]
