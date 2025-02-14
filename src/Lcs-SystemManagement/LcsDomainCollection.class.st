Class {
	#name : #LcsDomainCollection,
	#superclass : #LcsDomainObject,
	#traits : 'LtCollection',
	#classTraits : 'LtCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definition' }
LcsDomainCollection class >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsIdentityCollectionSlot new
]

{ #category : #accessing }
LcsDomainCollection >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #accessing }
LcsDomainCollection >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]

{ #category : #queries }
LcsDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : #search }
LcsDomainCollection >> findWithKey: anObject [
	^ self collection detect: [ :each | each key = anObject ] ifNone: [  ]
]

{ #category : #'domain collection' }
LcsDomainCollection >> pendingAdds [
	^ self currentUnitOfWork pendingAddsIn: self
]

{ #category : #'domain collection' }
LcsDomainCollection >> pendingDeletes [
	^ self currentUnitOfWork pendingDeletesFromCollection: self
]
