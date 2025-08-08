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

{ #category : #queries }
LcsDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : #search }
LcsDomainCollection >> findWithKey: anObject [
	^ self collection detect: [ :each | each key = anObject ] ifNone: [  ]
]

{ #category : #'gt views' }
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

{ #category : #'gt views' }
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
