Class {
	#name : #LcsWarRabbitLibrayImporter,
	#superclass : #LcsObject,
	#instVars : [
		'library',
		'currentCategory',
		'currentAuthors',
		'importedLines',
		'items'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsWarRabbitLibrayImporter class >> newOn: aLibrary [ 
	^ self new
		initializeOn: aLibrary;
		yourself
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentAuthors [
	^ currentAuthors
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentAuthors: anObject [
	currentAuthors := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentCategory [
	^ currentCategory
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentLine [
	^ self importedLines last
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> importLine: aString [
	self importedLines add: aString.
	self items add: (LcsUnknownLibraryItem newOn: aString)
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> importedLines [
	^ importedLines
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> importedLines: anObject [
	importedLines := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> initialize [
	super initialize.
	self importedLines: OrderedCollection new
]

{ #category : #initialize }
LcsWarRabbitLibrayImporter >> initializeOn: aLibrary [ 
	self library: aLibrary
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> items [
	^ items ifNil: [items := OrderedCollection new]
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> items: aCollection [
	items := aCollection
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> library [
	^ library
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> library: anObject [
	library := anObject
]
