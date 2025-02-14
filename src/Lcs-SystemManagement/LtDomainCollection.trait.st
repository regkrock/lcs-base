Trait {
	#name : #LtDomainCollection,
	#traits : 'LtCollection',
	#classTraits : 'LtCollection classTrait',
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'slot definition' }
LtDomainCollection classSide >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsIdentityCollectionSlot new
]

{ #category : #'as yet unclassified' }
LtDomainCollection >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #'as yet unclassified' }
LtDomainCollection >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]

{ #category : #queries }
LtDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]
