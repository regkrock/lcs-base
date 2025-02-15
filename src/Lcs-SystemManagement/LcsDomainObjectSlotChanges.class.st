Class {
	#name : #LcsDomainObjectSlotChanges,
	#superclass : #LcsSupportDomainObject,
	#traits : 'LtDictionaryDomainCollection',
	#classTraits : 'LtDictionaryDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #accessing }
LcsDomainObjectSlotChanges >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #accessing }
LcsDomainObjectSlotChanges >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]
