Class {
	#name : 'LuiCssClassesProperty',
	#superclass : 'LuiComponentProperty',
	#instVars : [
		'cssClasses'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant\t' }
LuiCssClassesProperty class >> propertyName [
	^ 'cssClasses'
]

{ #category : 'css classes' }
LuiCssClassesProperty >> addCssClass: aString [
	(self cssClasses includes: aString) ifFalse: [
		self cssClasses add: aString.
		self clearCache. ]
]

{ #category : 'css classes\\' }
LuiCssClassesProperty >> addCssClasses: anOrderedCollection [
	anOrderedCollection do: [ :eachCssClass |
		self addCssClass: eachCssClass ]
]

{ #category : 'accessing' }
LuiCssClassesProperty >> cachedValue [
	^ cachedValue ifNil: [ cachedValue := self cssClassesString ]
]

{ #category : 'css classes' }
LuiCssClassesProperty >> cssClass: aString [
	self removeAllCssClasses.
	self addCssClass: aString
]

{ #category : 'accessing' }
LuiCssClassesProperty >> cssClasses [
	^ cssClasses
]

{ #category : 'accessing' }
LuiCssClassesProperty >> cssClasses: anObject [ 
	cssClasses := anObject
]

{ #category : 'asking' }
LuiCssClassesProperty >> cssClassesString [
	| stream |
	stream := WriteStream on: String new.
	self cssClasses do: [:each | stream  nextPutAll: each ] separatedBy: [stream space].
	^stream contents
]

{ #category : 'initialize' }
LuiCssClassesProperty >> initialize [
	super initialize.
	self cssClasses: OrderedCollection new.
	self valueBlock: [ self cssClassesString ];
	tagAttributeSetSelector: #class:
]

{ #category : 'css classes' }
LuiCssClassesProperty >> removeAllCssClasses [
	self removeCssClasses: self cssClasses copy 
]

{ #category : 'css classes' }
LuiCssClassesProperty >> removeCssClass: aString [
	(self cssClasses includes: aString) ifTrue: [
		self cssClasses remove: aString ifAbsent: [ ].
		self clearCache ]
]

{ #category : 'css classes' }
LuiCssClassesProperty >> removeCssClasses: aCollection [
	aCollection copy do: [ :eachClass | self removeCssClass: eachClass ]
]

{ #category : 'css classes\\' }
LuiCssClassesProperty >> replaceExistingCssClassesWithCssClass: aString [
	self removeAllCssClasses.
	self addCssClass: aString
]
