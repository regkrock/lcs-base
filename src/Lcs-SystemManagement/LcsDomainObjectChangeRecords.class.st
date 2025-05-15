Class {
	#name : #LcsDomainObjectChangeRecords,
	#superclass : #LcsSupportDomainObject,
	#traits : 'LtOrderedCollectionDomainCollection',
	#classTraits : 'LtOrderedCollectionDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definition' }
LcsDomainObjectChangeRecords class >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : #history }
LcsDomainObjectChangeRecords >> addChangeRecord [
	^ self collection first
]

{ #category : #history }
LcsDomainObjectChangeRecords >> addSlotChangesOf: aSlotName to: slotChangeHistory [
	self collection reverseDo: [ :eachChangeRecord |
		eachChangeRecord addSlotChangesOf: aSlotName to: slotChangeHistory ].
	slotChangeHistory isEmpty ifTrue: [
		slotChangeHistory add: (
				Array 
					with: aSlotName 
					with: (self domainObject perform: aSlotName asSymbol) printString 
					with: self  parent created printString)]
]

{ #category : #accessing }
LcsDomainObjectChangeRecords >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #accessing }
LcsDomainObjectChangeRecords >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]

{ #category : #'history saving' }
LcsDomainObjectChangeRecords >> domainObject [
	^ self parent domainObject
]

{ #category : #history }
LcsDomainObjectChangeRecords >> domainObjectHistory [
	^ self parent domainObjectHistory
]

{ #category : #history }
LcsDomainObjectChangeRecords >> lastUpdateTimestamp [
	^ self collection last created
]

{ #category : #'as yet unclassified' }
LcsDomainObjectChangeRecords >> lastUpdatedUser [
	^ self collection last user
]

{ #category : #'as yet unclassified' }
LcsDomainObjectChangeRecords >> newChangeRecord [
	| newRecord |
	newRecord :=
		LcsDomainObjectChangeRecord new
			parent: self;
			user: self parent currentUser;
			yourself.
	self collection add: newRecord.
	^ newRecord
]
