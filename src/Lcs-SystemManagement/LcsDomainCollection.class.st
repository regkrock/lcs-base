Class {
	#name : #LcsDomainCollection,
	#superclass : #LcsDomainObject,
	#traits : 'LtIdentitySetDomainCollection',
	#classTraits : 'LtIdentitySetDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definitions' }
LcsDomainCollection class >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsIdentitySetSlot new
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

{ #category : #'gt view' }
LcsDomainCollection >> gtPendingAddsView: aView [
	<gtView>
	self pendingAdds ifEmpty: [ ^ aView empty ].
	^ aView forward
		title: 'Pending Adds' translated;
		priority: 2;
		object: [ self pendingAdds ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : #'gt view' }
LcsDomainCollection >> gtPendingDeletesView: aView [
	<gtView>
	self pendingDeletes ifEmpty: [ ^ aView empty ].
	^ aView forward
		title: 'Pending Deletes' translated;
		priority: 2;
		object: [ self pendingDeletes ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : #'domain collection' }
LcsDomainCollection >> pendingAdds [
	^ self currentUnitOfWork pendingAddsIn: self
]

{ #category : #'domain collection' }
LcsDomainCollection >> pendingDeletes [
	^ self currentUnitOfWork pendingDeletesFromCollection: self
]
