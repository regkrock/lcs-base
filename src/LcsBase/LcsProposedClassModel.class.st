Class {
	#name : 'LcsProposedClassModel',
	#superclass : 'LcsClassModel',
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsProposedClassModel class >> newOn: aClassname [
	^ self new 
		initalizeOn: aClassname;
		yourself
]

{ #category : 'as yet unclassified' }
LcsProposedClassModel >> borderColor [
	^ Color blue
]

{ #category : 'as yet unclassified' }
LcsProposedClassModel >> classnameText [
	^ self modelClassname asRopedText foreground: self foregroundColor
]

{ #category : 'as yet unclassified' }
LcsProposedClassModel >> foregroundColor [
	^ self modelClass ifNil: [ Color blue ] ifNotNil: [ Color brown]
]

{ #category : 'initialize' }
LcsProposedClassModel >> initalizeOn: aClassname [ 
	self modelClassname: aClassname
]

{ #category : 'accessing' }
LcsProposedClassModel >> modelClassname: aClassname [
	super modelClassname: aClassname
]

{ #category : 'printing' }
LcsProposedClassModel >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' ('; 
		nextPutAll: self modelClassname asString;
		nextPutAll: ')'
]

{ #category : 'as yet unclassified' }
LcsProposedClassModel >> superclass [
	^ [ self modelSuperclassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]
