Class {
	#name : #LcsCollection,
	#superclass : #LcsObject,
	#instVars : [
		'collection'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsCollection >> collection [
	^ collection
]

{ #category : #accessing }
LcsCollection >> collection: anObject [
	collection := anObject
]

{ #category : #'defaults ' }
LcsCollection >> collectionClass [
	self subclassResponsibility
]

{ #category : #accessing }
LcsCollection >> initialize [ 

	super initialize.
	self collection: self collectionClass new
]
