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
