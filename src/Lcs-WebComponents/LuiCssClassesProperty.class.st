Class {
	#name : #LuiCssClassesProperty,
	#superclass : #LuiComponentProperty,
	#instVars : [
		'cssClasses'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'constant\t' }
LuiCssClassesProperty class >> propertyName [
	^ 'cssClasses'
]

{ #category : #'css classes' }
LuiCssClassesProperty >> addCssClass: aString [
	(self cssClasses includes: aString) ifFalse: [
		self cssClasses add: aString.
		self clearCache. ]
]

{ #category : #'css classes\\' }
LuiCssClassesProperty >> addCssClasses: anOrderedCollection [
	anOrderedCollection do: [ :eachCssClass |
		self addCssClass: eachCssClass ]
]

{ #category : #accessing }
LuiCssClassesProperty >> cssClasses [
	^ cssClasses
]

{ #category : #accessing }
LuiCssClassesProperty >> cssClasses: anObject [ 
	cssClasses := anObject
]

{ #category : #asking }
LuiCssClassesProperty >> cssClassesString [
	| stream |
	stream := WriteStream on: String new.
	self cssClasses do: [:each | stream  nextPutAll: each ] separatedBy: [stream space].
	^stream contents
]

{ #category : #initialize }
LuiCssClassesProperty >> initialize [
	super initialize.
	self cssClasses: OrderedCollection new.
	self valueBlock: [ self cssClassesString]
]

{ #category : #'css classes' }
LuiCssClassesProperty >> removeAllCssClasses [
	self removeCssClasses: self cssClasses copy 
]

{ #category : #'css classes' }
LuiCssClassesProperty >> removeCssClass: aString [
	(self cssClasses includes: aString) ifTrue: [
		self cssClasses remove: aString ifAbsent: [ ].
		self clearCache ]
]

{ #category : #'css classes' }
LuiCssClassesProperty >> removeCssClasses: aCollection [
	aCollection do: [ :eachClass | self removeCssClass: eachClass ]
]

{ #category : #'css classes\\' }
LuiCssClassesProperty >> replaceExistingCssClassesWithCssClass: aString [
	self removeAllCssClasses.
	self addCssClass: aString
]
