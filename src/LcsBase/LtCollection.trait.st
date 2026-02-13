Trait {
	#name : 'LtCollection',
	#instVars : [
		'collection'
	],
	#category : 'LcsBase-Traits',
	#package : 'LcsBase',
	#tag : 'Traits'
}

{ #category : 'collection' }
LtCollection >> add: anObject [
	^ self collection add: anObject
]

{ #category : 'collection' }
LtCollection >> any [
	^ self collection any
]

{ #category : 'collection' }
LtCollection >> collect: aBlock [
	^ self collection collect: aBlock
]

{ #category : 'accessing' }
LtCollection >> collection [
	^ collection
]

{ #category : 'accessing' }
LtCollection >> collection: anObject [
	collection := anObject
]

{ #category : 'collection' }
LtCollection >> collectionSize [
	^ self collection size
]

{ #category : 'collection' }
LtCollection >> detect: aBlock [
	^ self collection detect: aBlock
]

{ #category : 'collection' }
LtCollection >> detect: aBlock ifNone: anIfNoneBlock [
	^ self collection detect: aBlock ifNone: anIfNoneBlock
]

{ #category : 'collection' }
LtCollection >> do: aBlock [
	^ self collection do: aBlock
]

{ #category : 'collection' }
LtCollection >> first [
	^ self collection first
]

{ #category : 'printing' }
LtCollection >> gtCollectionSizeThreshold [
	"Return the maximum collection size that GT supports while showing all elements.
	When this threshold is reached, we no longer show certain views that would take too much resources."

	^ 16rFFFF "65535"
]

{ #category : 'printing' }
LtCollection >> gtDisplayOn: stream [
	"super gtDisplayOn: aStream.
	aStream
		nextPutAll: '[' , self collection size printString , ' item'
				, (self collection size = 1 ifTrue: [ '' ] ifFalse: [ 's' ]) , ']'.
	self collection isEmpty ifTrue: [ ^ self ].
	aStream nextPutAll: '('.
	self collection
		do: [ :each | aStream nextPutAll: each description printString ]
		separatedBy: [ aStream nextPutAll: ',' ].
	aStream nextPutAll: ')'."

	self printNameOn: stream.
		stream
		space;
		nextPut: $[.
	self gtPrintCollectionSizeOn: stream.
	stream
		nextPut: $];
		space.
	self collectionSize <= self gtCollectionSizeThreshold
		ifTrue: [ self printElementsOn: stream ]
]

{ #category : 'gt view' }
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

{ #category : 'printing' }
LtCollection >> gtPrintCollectionSizeOn: stream [
	stream
		print: self collectionSize;
		nextPutAll: (' item' asPluralBasedOn: self collectionSize)
]

{ #category : 'collection' }
LtCollection >> includes: anObject [
	^ self collection includes: anObject
]

{ #category : 'collection' }
LtCollection >> inject: anObject into: aBlock [
	^ self collection inject: anObject into: aBlock
]

{ #category : 'testing' }
LtCollection >> isEmpty [
	^ self collection isEmpty
]

{ #category : 'testing' }
LtCollection >> isNotEmpty [
	^ self collection notEmpty
]

{ #category : 'collection' }
LtCollection >> last [
	^ self collection last
]

{ #category : 'printing' }
LtCollection >> printElementsOn: aStream [
	"List elements betwen () and separated by spaces.
	Is used by printOn: and other related printing methods."

	"(String streamContents: [:s|
		{10. 'hello'} printElementsOn: s])
		>>> '(10 ''hello'')'"
	"(String streamContents: [:s|
		#() printElementsOn: s])
		>>> '()'"

	"Note: The original code used #skip:, but some streams do not support that,
	 and we don't really need it."

	aStream nextPut: $(.
	self collection do: [:element | aStream print: element] separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : 'printing' }
LtCollection >> printNameOn: aStream [
	super printOn: aStream
]

{ #category : 'collection' }
LtCollection >> reject: aBlock [
	^ self collection reject: aBlock
]

{ #category : 'collection' }
LtCollection >> remove: anObject [
	^ self remove: anObject ifAbsent: [ ]
]

{ #category : 'collection' }
LtCollection >> remove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: [ ]
]

{ #category : 'collection' }
LtCollection >> removeAll [
	^self collection removeAll
]

{ #category : 'collection' }
LtCollection >> select: aBlock [
	^ self collection select: aBlock
]
