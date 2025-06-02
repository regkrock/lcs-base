Class {
	#name : #LcsClassWrapper,
	#superclass : #LcsModelClass,
	#instVars : [
		'realSuperclassName'
	],
	#category : #'LcsBase-Core'
}

{ #category : #'as yet unclassified' }
LcsClassWrapper >> borderColor [
	^ Color gray
]

{ #category : #'as yet unclassified' }
LcsClassWrapper >> classnameText [
	^ self modelClassname asRopedText foreground: self foregroundColor
]

{ #category : #'as yet unclassified' }
LcsClassWrapper >> foregroundColor [
	^ Color gray
]

{ #category : #'as yet unclassified' }
LcsClassWrapper >> modelClass: aClass [
	self modelClassname: aClass name.
	self modelSuperclassName: aClass superclass name 
]

{ #category : #printing }
LcsClassWrapper >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' ('; 
		nextPutAll: self modelClassname asString;
		nextPutAll: ')'
]
