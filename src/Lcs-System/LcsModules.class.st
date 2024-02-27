Class {
	#name : #LcsModules,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'collection'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsModules class >> collectionClass [
	^LcsSmalltalkConfiguration stringDictionaryClass
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
LcsModules >> hasElements [
	^self collection notEmpty
]

{ #category : #accessing }
LcsModules >> hasNoElements [
	^self collection isEmpty
]

{ #category : #accessing }
LcsModules >> initialize [ 
	super initialize.
	self collection: Dictionary new
]

{ #category : #accessing }
LcsModules >> moduleNamed: aString [
	^self moduleNamed: aString ifAbsent: [self error: 'Module not found: ' , aString asString]
]

{ #category : #accessing }
LcsModules >> moduleNamed: aString ifAbsent: aBlock [
	^self collection at: aString ifAbsent: aBlock
]

{ #category : #accessing }
LcsModules >> parent [
	^ parent
]

{ #category : #accessing }
LcsModules >> parent: anObject [
	parent := anObject
]
