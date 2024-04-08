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

{ #category : #'collection\t' }
LcsDomainCollection >> add: anObject [
	^ self collection add: anObject
]

{ #category : #'collection\t' }
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

{ #category : #accessing }
LcsDomainCollection >> detect: aBlock [
	^ self collection detect: aBlock
]

{ #category : #'collection\t' }
LcsDomainCollection >> detect: aBlock ifNone: anIfNoneBlock [
	^ self collection detect: aBlock ifNone: anIfNoneBlock
]

{ #category : #'collection\t' }
LcsDomainCollection >> do: aBlock [
	^ self collection do: aBlock
]

{ #category : #'testing ' }
LcsDomainCollection >> hasElements [
	^ self collection notEmpty
]

{ #category : #'testing ' }
LcsDomainCollection >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #'collection\t' }
LcsDomainCollection >> includes: anObject [
	^ self collection includes: anObject
]

{ #category : #initialization }
LcsDomainCollection >> initialize [
	super initialize.
	self collection: self collectionClass new
]

{ #category : #'collection\t' }
LcsDomainCollection >> inject: anObject into: aBlock [
	^ self collection inject: anObject into: aBlock
]

{ #category : #'collection\t' }
LcsDomainCollection >> reject: aBlock [
	^ self collection reject: aBlock
]

{ #category : #'collection\t' }
LcsDomainCollection >> remove: anObject [
	^ self collection remove: anObject
]

{ #category : #'collection\t' }
LcsDomainCollection >> remove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: [ ]
]

{ #category : #'collection\t' }
LcsDomainCollection >> removeAll [
	^ self collection removeAll
]

{ #category : #'collection\t' }
LcsDomainCollection >> select: aBlock [
	^ self collection select: aBlock
]

{ #category : #'collection\t' }
LcsDomainCollection >> size [
	^ self collection size
]
