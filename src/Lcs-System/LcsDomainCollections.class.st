Class {
	#name : #LcsDomainCollections,
	#superclass : #LcsObject,
	#instVars : [
		'collection',
		'parent'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsDomainCollections >> collection [
	^ collection
]

{ #category : #accessing }
LcsDomainCollections >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
LcsDomainCollections >> initialize [
	super initialize.
	self collection: LcsSmalltalkConfiguration stringDictionaryClass new
]

{ #category : #accessing }
LcsDomainCollections >> parent [
	^ parent
]

{ #category : #accessing }
LcsDomainCollections >> parent: anObject [
	parent := anObject
]
