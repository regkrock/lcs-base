Class {
	#name : #LcsDomainCollection,
	#superclass : #LcsDomainObject,
	#instVars : [
		'collection'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #accessing }
LcsDomainCollection class >> collectionClass [
	^IdentitySet new
]

{ #category : #accessing }
LcsDomainCollection >> collection [
	^ collection
]

{ #category : #accessing }
LcsDomainCollection >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
LcsDomainCollection >> collectionClass [
	^self class collectionClass
]

{ #category : #accessing }
LcsDomainCollection >> hasElements [
	^self collection isEmpty not
]

{ #category : #accessing }
LcsDomainCollection >> hasNoElements [
	^self collection isEmpty
]

{ #category : #accessing }
LcsDomainCollection >> initialize [
	super initialize.
	self collection: self collectionClass new
]
