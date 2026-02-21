Trait {
	#name : 'LtDomainCollection',
	#traits : 'LtCollection',
	#classTraits : 'LtCollection classTrait',
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'collection' }
LtDomainCollection >> add: aDomainObject [
	aDomainObject parent ifNil: [ aDomainObject parent: self ].
	^ self currentUnitOfWork addPendingAddOf: aDomainObject to: self
]

{ #category : 'accessing' }
LtDomainCollection >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : 'accessing' }
LtDomainCollection >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]

{ #category : 'queries' }
LtDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : 'collection' }
LtDomainCollection >> directAdd: anObject [
	^ self collection add: anObject
]

{ #category : 'collection' }
LtDomainCollection >> directRemove: anObject [
	^ self directRemove: anObject ifAbsent: [ ]
]

{ #category : 'collection' }
LtDomainCollection >> directRemove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: aBlock
]

{ #category : 'gt views' }
LtDomainCollection >> gtItemsFor: aView [
	<gtView>
	| columnedListView |
	columnedListView := 
		aView columnedList
			title: 'Items' translated;
			priority: 0.5;
			items: [ (self collection ifNil: [ OrderedCollection new]) asOrderedCollection ];
			actionUpdateButton.
	self collection notEmpty ifTrue: [
		self collection any collectionViewSlotDefinitions do: [ :eachSlotDefinition |
			columnedListView 
				column: eachSlotDefinition label 
				text: [:domainObject | (domainObject perform: eachSlotDefinition getterSelector) asString ] 
				width: 100 ] ].
	^ columnedListView
]

{ #category : 'printing' }
LtDomainCollection >> gtPrintCollectionSizeOn: stream [
	stream
		print: self collectionSize;
		nextPutAll: (' item' asPluralBasedOn: self collectionSize).
	self pendingAdds notEmpty ifTrue: [
		stream
			print: ', Pending Adds: ';
			print: self pendingAddsSize;
			nextPutAll: (' item' asPluralBasedOn: self pendingAddsSize)].
	self pendingDeletes notEmpty ifTrue: [
		stream
			print: ', Pending Deletes: ';
			print: self pendingDeletesSize;
			nextPutAll: (' item' asPluralBasedOn: self pendingDeletesSize)]
]

{ #category : 'collection' }
LtDomainCollection >> includes: anObject [
	^ (self collection includes: anObject)
		or: [ self pendingAdds includes: anObject ] 
]

{ #category : 'collection' }
LtDomainCollection >> remove: anObject [
	(self includes: anObject) ifFalse: [ ^ nil ].
	^ self currentUnitOfWork addPendingDeletionOf: anObject from: self
]

{ #category : 'collection' }
LtDomainCollection >> remove: anObject ifAbsent: aBlock [
	"self verifyCanARemove: anObject."
	(self includes: anObject) ifFalse: [ ^ aBlock value ].
	^ self currentUnitOfWork addPendingDeletionOf: anObject from: self
]
