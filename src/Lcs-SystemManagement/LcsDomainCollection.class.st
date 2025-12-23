Class {
	#name : 'LcsDomainCollection',
	#superclass : 'LcsBaseDomainCollection',
	#traits : 'LtIdentitySetDomainCollection',
	#classTraits : 'LtIdentitySetDomainCollection classTrait',
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsDomainCollection class >> collectionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsIdentitySetSlot new
		priority: 1;
		yourself
]

{ #category : 'configuration' }
LcsDomainCollection class >> collectionType [
	^'concrete'
]

{ #category : 'as yet unclassified' }
LcsDomainCollection >> accessorSlotNameAndValue [
	| nameAndValues |
	nameAndValues := super accessorSlotNameAndValue.
	^ nameAndValues 
		add: ('pendingAdds' -> self pendingAdds);
		add: ('pendingDeletes' -> self pendingDeletes);
		yourself
]

{ #category : 'queries' }
LcsDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : 'querying' }
LcsDomainCollection >> find: aBlock [
	^ self find: aBlock ifNone: [ nil ]
]

{ #category : 'querying' }
LcsDomainCollection >> find: aBlock ifNone: aNoneBlock [
	| item |
	item := self collection detect: aBlock ifNone: [ nil ].
	item notNil ifTrue: [ ^ item ].
	item := self pendingAdds detect: aBlock ifNone: [ nil ].
	item notNil ifTrue: [ ^ item ].
	^ aNoneBlock value
]

{ #category : 'querying' }
LcsDomainCollection >> findItemIn: anAccessPath matching: anObject [
	| result |
	result := self findItemsIn: anAccessPath matching: anObject.
	result isEmpty ifTrue: [ ^ nil ].
	result size = 1 ifFalse: [LcsError signal: 'More than one item found'].
	^ result any
]

{ #category : 'querying' }
LcsDomainCollection >> findItemIn: anAccessPath matching: anObject ifNone: aBlock [
	| result |
	result := self findItemsIn: anAccessPath matching: anObject.
	result isEmpty ifTrue: [ ^ aBlock value ].
	result size = 1 ifFalse: [LcsError signal: 'More than one item found'].
	^ result any
]

{ #category : 'querying' }
LcsDomainCollection >> findItemsIn: anAccessPath matching: anObject [
	| foundItems |
	foundItems := OrderedCollection new.
	{self collection. self pendingAdds} do: [ :eachCollection | 
		foundItems addAll: (
			self
				findItemsIn: anAccessPath
				matching: anObject
				collection: eachCollection) ].
	^ foundItems
]

{ #category : 'querying' }
LcsDomainCollection >> findItemsIn: anAccessPath matching: anObject collection: aCollection [
	^ aCollection select: [ :each | 
			| result |
			result := each.
			anAccessPath do: [ :eachSlotName | result := result perform: eachSlotName asSymbol ].
			result = anObject ]
]

{ #category : 'querying' }
LcsDomainCollection >> findWithKey: anObject [
	^ self findWithKey: anObject ifNone: [ ]
]

{ #category : 'querying' }
LcsDomainCollection >> findWithKey: anObject ifNone: aBlock [
	| result |
	result := self collection detect: [ :each | each key = anObject ] ifNone: [ nil ].
	result notNil ifTrue: [ ^ result ].
	^ self pendingAdds detect: [ :each | each key = anObject ] ifNone: aBlock
]

{ #category : 'gt views' }
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
				text: [:parentDomainObject | (parentDomainObject perform: eachSlotDefinition getterSelector) asString ] 
				width: 100 ] ].
	^ columnedListView
]

{ #category : 'gt views' }
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

{ #category : 'domain collection' }
LcsDomainCollection >> pendingAdds [
	^ self currentUnitOfWork pendingAddsIn: self
]

{ #category : 'domain collection' }
LcsDomainCollection >> pendingDeletes [
	^ self currentUnitOfWork pendingDeletesIn: self
]
