Class {
	#name : #LcsModules,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'collection'
	],
	#category : #LcsBase
}

{ #category : #accessing }
LcsModules class >> collectionClass [
	^ LcsSmalltalkConfiguration stringDictionaryClass
]

{ #category : #accessing }
LcsModules >> at: aKey [
	^ self collection at: aKey
]

{ #category : #accessing }
LcsModules >> buildModuleFor: eachModuleClass [

	| module |
	module := eachModuleClass new.
	module parent: self.
	self collection at: module moduleName put: module.
]

{ #category : #accessing }
LcsModules >> collection [
	^ collection
]

{ #category : #accessing }
LcsModules >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
LcsModules >> contentsDo: aBlock [
	self collection do: [ :eachElement | aBlock value: eachElement ]
]

{ #category : #testing }
LcsModules >> hasElements [
	^ self collection notEmpty
]

{ #category : #testing }
LcsModules >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #initialize }
LcsModules >> initialize [ 
	super initialize.
	self collection: Dictionary new
]

{ #category : #accessing }
LcsModules >> initializeModel [
	self collection valuesDo: [ :eachModule | eachModule initializeModel ]
]

{ #category : #modules }
LcsModules >> moduleNamed: aString [
	^ self moduleNamed: aString ifAbsent: [ LcsModuleNotFoundError signal: 'Module not found: ' , aString asString ]
]

{ #category : #modules }
LcsModules >> moduleNamed: aString ifAbsent: aBlock [
	^ self collection at: aString ifAbsent: aBlock
]

{ #category : #modules }
LcsModules >> numberOfModules [
	^ self collection size
]

{ #category : #accessing }
LcsModules >> parent [
	^ parent
]

{ #category : #accessing }
LcsModules >> parent: anObject [
	parent := anObject
]
