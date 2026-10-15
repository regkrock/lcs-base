Class {
	#name : 'LcsBaseDomainCollection',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'caption'
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

{ #category : 'accessing' }
LcsBaseDomainCollection >> actualCollection [
	self collection
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> caption [
	^ self slotVarNamed: 'caption'
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> caption: anObject [
	self slotVarNamed: 'caption' put: anObject
]

{ #category : 'accessing' }
LcsBaseDomainCollection >> collection [
	self subclassResponsibility
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
