Class {
	#name : #LcsProposedClass,
	#superclass : #LcsObject,
	#instVars : [
		'classname',
		'superclassName'
	],
	#category : #'LcsBase-Core'
}

{ #category : #accessing }
LcsProposedClass >> classname [
	^ classname
]

{ #category : #accessing }
LcsProposedClass >> classname: anObject [
	classname := anObject
]

{ #category : #printing }
LcsProposedClass >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' ('; 
		nextPutAll: self classname asString;
		nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
LcsProposedClass >> superclass [
	^ [ self superclassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsProposedClass >> superclassName [
	^ superclassName
]

{ #category : #accessing }
LcsProposedClass >> superclassName: anObject [
	superclassName := anObject
]
