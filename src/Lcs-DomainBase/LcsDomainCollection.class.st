Class {
	#name : #LcsDomainCollection,
	#superclass : #LcsDomainObject,
	#instVars : [
		'collection'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #configuration }
LcsDomainCollection class >> collectionClass [
	^IdentitySet new
]

{ #category : #'instace creation' }
LcsDomainCollection class >> new [
	^ self newWithCollection: self collectionClass
]

{ #category : #'instace creation' }
LcsDomainCollection class >> newWithCollection: aCollection [
	^ self basicNew
		initialize;
		collection: aCollection;
		yourself
]

{ #category : #collection }
LcsDomainCollection >> add: anObject [
	^ self collection add: anObject
]

{ #category : #collection }
LcsDomainCollection >> collect: aBlock [
	^ self collection collect: aBlock
]

{ #category : #accessing }
LcsDomainCollection >> collection [
	^ collection
]

{ #category : #accessing }
LcsDomainCollection >> collection: anObject [
	collection := anObject
]

{ #category : #configuration }
LcsDomainCollection >> collectionClass [
	^ self class collectionClass
]

{ #category : #queries }
LcsDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : #collection }
LcsDomainCollection >> detect: aBlock [
	^ self collection detect: aBlock
]

{ #category : #collection }
LcsDomainCollection >> detect: aBlock ifNone: anIfNoneBlock [
	^ self collection detect: aBlock ifNone: anIfNoneBlock
]

{ #category : #collection }
LcsDomainCollection >> do: aBlock [
	^ self collection do: aBlock
]

{ #category : #search }
LcsDomainCollection >> findWithKey: anObject [
	^ self collection detect: [ :each | each key = anObject ] ifNone: [  ]
]

{ #category : #testing }
LcsDomainCollection >> hasElements [
	^ self collection notEmpty
]

{ #category : #testing }
LcsDomainCollection >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #collection }
LcsDomainCollection >> includes: anObject [
	^ self collection includes: anObject
]

{ #category : #initialization }
LcsDomainCollection >> initialize [
	super initialize
]

{ #category : #collection }
LcsDomainCollection >> inject: anObject into: aBlock [
	^ self collection inject: anObject into: aBlock
]

{ #category : #collection }
LcsDomainCollection >> reject: aBlock [
	^ self collection reject: aBlock
]

{ #category : #collection }
LcsDomainCollection >> remove: anObject [
	^ self collection remove: anObject
]

{ #category : #collection }
LcsDomainCollection >> remove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: [ ]
]

{ #category : #collection }
LcsDomainCollection >> removeAll [
	^ self collection removeAll
]

{ #category : #collection }
LcsDomainCollection >> select: aBlock [
	^ self collection select: aBlock
]

{ #category : #collection }
LcsDomainCollection >> size [
	^ self collection size
]
