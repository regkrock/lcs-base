Class {
	#name : #LcsDomainObjectChangeRecords,
	#superclass : #LcsSupportDomainObject,
	#traits : 'LtOrderedCollectionDomainCollection',
	#classTraits : 'LtOrderedCollectionDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #accessing }
LcsDomainObjectChangeRecords >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #accessing }
LcsDomainObjectChangeRecords >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]
