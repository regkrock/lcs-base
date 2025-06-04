Class {
	#name : #LcsExistingClassModel,
	#superclass : #LcsClassModel,
	#instVars : [
		'modelClass'
	],
	#category : #'LcsBase-Core'
}

{ #category : #'instance creation' }
LcsExistingClassModel class >> newOn: aClass [
	^ self new 
		initializeOn: aClass;
		yourself
]

{ #category : #'as yet unclassified' }
LcsExistingClassModel >> borderColor [
	^ Color gray
]

{ #category : #'as yet unclassified' }
LcsExistingClassModel >> classnameText [
	^ self modelClassname asRopedText foreground: self foregroundColor
]

{ #category : #'as yet unclassified' }
LcsExistingClassModel >> foregroundColor [
	^ Color gray
]

{ #category : #'instance creation' }
LcsExistingClassModel >> initializeOn: aClass [ 
	self modelClass: aClass.
	self modelClassname: aClass name asString.
	self modelSuperclassName: aClass superclass name asString.
	self modelSuperclass: aClass superclass.
]

{ #category : #accessing }
LcsExistingClassModel >> modelClass [
	^ modelClass
]

{ #category : #accessing }
LcsExistingClassModel >> modelClass: anObject [
	modelClass := anObject
]

{ #category : #printing }
LcsExistingClassModel >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' ('; 
		nextPutAll: self modelClassname asString;
		nextPutAll: ')'
]
