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

{ #category : #'default instance' }
LcsDomainCollection >> find: aBlock [
	^ self find: aBlock ifNone: [ nil ]
]

{ #category : #'default instance' }
LcsDomainCollection >> find: aBlock ifNone: aNoneBlock [
	| defaultInstance |
	defaultInstance := self collection detect: aBlock ifNone: [ nil ].
	defaultInstance notNil ifTrue: [ ^ defaultInstance ].
	defaultInstance := self pendingAdds detect: aBlock ifNone: [ nil ].
	defaultInstance notNil ifTrue: [ ^ defaultInstance ].
	^ aNoneBlock cull: self
]

{ #category : #search }
LcsDomainCollection >> findWithKey: anObject [
	^ self findWithKey: anObject ifNone: [ ]
]

{ #category : #search }
LcsDomainCollection >> findWithKey: anObject ifNone: aBlock [
	^ self collection detect: [ :each | each key = anObject ] ifNone: aBlock
]

{ #category : #'gt views' }
LcsDomainCollection >> gtPendingAddsView: aView [
	<gtView>
	| columnedListView |
	self pendingAdds ifEmpty: [ ^ aView empty ].
	"^ aView forward
		title: 'Pending Adds' translated;
		priority: 2;
		object: [ self pendingAdds ];
		view: #gtItemsFor:;
		actionUpdateButton"
	self collection isNil ifTrue: [ ^ aView empty ].
	columnedListView := 
		aView columnedList
			title: 'Pending Adds' translated;
			priority: 0.5;
			items: [ self pendingAdds asOrderedCollection ];
			actionUpdateButton.
	self pendingAdds notEmpty ifTrue: [
		self pendingAdds any collectionViewSlotDefinitions do: [ :eachSlotDefinition |
			columnedListView 
				column: eachSlotDefinition label 
				text: [:domainObject | (domainObject perform: eachSlotDefinition getterSelector) asString ] 
				width: 100 ] ].
	^ columnedListView
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
