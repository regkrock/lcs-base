Class {
	#name : #LcsParentObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'LcsBase-Core'
}

{ #category : #'instance creation' }
LcsParentObject class >> newOn: anOjbect [
	^ self new
		initializeOn: anOjbect;
		yourself
]

{ #category : #inititialize }
LcsParentObject >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : #accessing }
LcsParentObject >> parent [
	^ parent
]

{ #category : #accessing }
LcsParentObject >> parent: anObject [
	parent := anObject
]
