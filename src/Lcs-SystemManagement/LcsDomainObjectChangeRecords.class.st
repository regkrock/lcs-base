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
		makeDirectVariableUpdate;
		yourself
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

{ #category : #'as yet unclassified' }
LcsDomainObjectChangeRecords >> newChangeRecord [
	| newRecord |
	newRecord :=
		LcsDomainObjectChangeRecord new
			parent: self;
			userUuid: self parent currentUser uuid;
			yourself.
	self collection add: newRecord.
	^ newRecord
]
