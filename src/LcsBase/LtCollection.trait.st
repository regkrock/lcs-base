Trait {
	#name : #LtCollection,
	#instVars : [
		'collection'
	],
	#category : #'LcsBase-Traits'
}

{ #category : #collection }
LtCollection >> add: anObject [
	^ self collection add: anObject
]

{ #category : #collection }
LtCollection >> collect: aBlock [
	^ self collection collect: aBlock
]

{ #category : #collection }
LtCollection >> collectionSize [
	^ self collection size
]

{ #category : #collection }
LtCollection >> detect: aBlock [
	^ self collection detect: aBlock
]

{ #category : #collection }
LtCollection >> detect: aBlock ifNone: anIfNoneBlock [
	^ self collection detect: aBlock ifNone: anIfNoneBlock
]

{ #category : #collection }
LtCollection >> do: aBlock [
	^ self collection do: aBlock
]

{ #category : #'gt view' }
LtCollection >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Items' translated;
		priority: 0.5;
		object: [ self collection ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : #testing }
LtCollection >> hasElements [
	^ self collection notEmpty
]

{ #category : #testing }
LtCollection >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #collection }
LtCollection >> includes: anObject [
	^ self collection includes: anObject
]

{ #category : #collection }
LtCollection >> inject: anObject into: aBlock [
	^ self collection inject: anObject into: aBlock
]

{ #category : #collection }
LtCollection >> reject: aBlock [
	^ self collection reject: aBlock
]

{ #category : #collection }
LtCollection >> remove: anObject [
	^ self collection remove: anObject
]

{ #category : #collection }
LtCollection >> remove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: [ ]
]

{ #category : #collection }
LtCollection >> removeAll [
	^self collection removeAll
]

{ #category : #collection }
LtCollection >> select: aBlock [
	^ self collection select: aBlock
]
