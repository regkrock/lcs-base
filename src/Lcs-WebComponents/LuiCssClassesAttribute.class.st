Class {
	#name : 'LuiCssClassesAttribute',
	#superclass : 'LuiComponentAttribute',
	#instVars : [
		'cssClasses'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant\t' }
LuiCssClassesAttribute class >> attributeName [
	^ 'cssClasses'
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> addCssClass: aString [
	(self cssClasses includes: aString) ifFalse: [
		self cssClasses add: aString.
		self clearCache. ]
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> addCssClasses: anOrderedCollection [
	anOrderedCollection do: [ :eachCssClass |
		self addCssClass: eachCssClass ]
]

{ #category : 'accessing' }
LuiCssClassesAttribute >> cachedValue [
	^ cachedValue ifNil: [ cachedValue := self cssClassesString ifEmpty: [ nil ] ]
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> cssClass: aString [
	self removeAllCssClasses.
	self addCssClass: aString
]

{ #category : 'accessing' }
LuiCssClassesAttribute >> cssClasses [
	^ cssClasses
]

{ #category : 'accessing' }
LuiCssClassesAttribute >> cssClasses: anObject [ 
	cssClasses := anObject
]

{ #category : 'asking' }
LuiCssClassesAttribute >> cssClassesString [
	| stream |
	stream := WriteStream on: String new.
	self cssClasses do: [:each | stream  nextPutAll: each ] separatedBy: [stream space].
	^stream contents
]

{ #category : 'initialize' }
LuiCssClassesAttribute >> initialize [
	super initialize.
	self cssClasses: OrderedCollection new.
	self valueBlock: [ self cssClassesString ];
	tagAttributeSetSelector: #class:
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> removeAllCssClasses [
	self removeCssClasses: self cssClasses copy 
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> removeCssClass: aString [
	(self cssClasses includes: aString) ifTrue: [
		self cssClasses remove: aString ifAbsent: [ ].
		self clearCache ]
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> removeCssClasses: aCollection [
	aCollection copy do: [ :eachClass | self removeCssClass: eachClass ]
]

{ #category : 'css classes' }
LuiCssClassesAttribute >> replaceExistingCssClassesWithCssClass: aString [
	self removeAllCssClasses.
	self addCssClass: aString
]
