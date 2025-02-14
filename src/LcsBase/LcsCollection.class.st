Class {
	#name : #LcsCollection,
	#superclass : #LcsObject,
	#traits : 'LtCollection',
	#classTraits : 'LtCollection classTrait',
	#instVars : [
		'parent'
	],
	#category : #'LcsBase-Core'
}

{ #category : #defaults }
LcsCollection class >> collectionClass [
	self subclassResponsibility
]

{ #category : #'instance creation' }
LcsCollection class >> newOn: anOjbect [
	^ self new
		initializeOn: anOjbect;
		yourself
]

{ #category : #accessing }
LcsCollection >> collection [
	^ collection
]

{ #category : #accessing }
LcsCollection >> collection: anObject [
	collection := anObject
]

{ #category : #defaults }
LcsCollection >> collectionClass [
	^ self class collectionClass
]

{ #category : #inititialize }
LcsCollection >> initialize [ 

	super initialize.
	self collection: self collectionClass new
]

{ #category : #inititialize }
LcsCollection >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : #accessing }
LcsCollection >> parent [
	^ parent
]

{ #category : #accessing }
LcsCollection >> parent: anObject [
	parent := anObject
]
