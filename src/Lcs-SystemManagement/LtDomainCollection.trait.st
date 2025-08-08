Trait {
	#name : #LtDomainCollection,
	#traits : 'LtCollection',
	#classTraits : 'LtCollection classTrait',
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #accessing }
LtDomainCollection >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #accessing }
LtDomainCollection >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]

{ #category : #queries }
LtDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : #'gt views' }
LtDomainCollection >> gtItemsFor: aView [
	<gtView>
	| columnedListView |
	self collection isNil ifTrue: [ ^ aView empty ].
	columnedListView := 
		aView columnedList
			title: 'Items' translated;
			priority: 0.5;
			items: [ self collection asOrderedCollection ];
			actionUpdateButton.
	self collection notEmpty ifTrue: [
		self collection any collectionViewSlotDefinitions do: [ :eachSlotDefinition |
			columnedListView 
				column: eachSlotDefinition label 
				text: [:domainObject | (domainObject perform: eachSlotDefinition getterSelector) asString ] 
				width: 100 ] ].
	^ columnedListView
]
