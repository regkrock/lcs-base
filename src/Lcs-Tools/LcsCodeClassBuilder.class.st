Class {
	#name : #LcsCodeClassBuilder,
	#superclass : #LcsBaseCodeClassBuilder,
	#instVars : [
		'defaultInstance',
		'superclassName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsCodeClassBuilder >> beDefaultInstance [
	defaultInstance := true
]

{ #category : #accessing }
LcsCodeClassBuilder >> defaultInstance [
	^ defaultInstance
]

{ #category : #accessing }
LcsCodeClassBuilder >> defaultInstance: aBoolean [ 
	defaultInstance := aBoolean
]

{ #category : #initialize }
LcsCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: false
]

{ #category : #testing }
LcsCodeClassBuilder >> isDefaultInstance [
	^ self defaultInstance == true
]

{ #category : #build }
LcsCodeClassBuilder >> superclassName [
	^ superclassName
]

{ #category : #build }
LcsCodeClassBuilder >> superclassName: aString [
	superclassName := aString
]
