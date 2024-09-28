Class {
	#name : #LuiCssClasses,
	#superclass : #Object,
	#instVars : [
		'cssClasses'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #action }
LuiCssClasses >> addCssClass: aString [
	(self cssClasses includes: aString) ifFalse: [ self cssClasses add: aString ]
]

{ #category : #'as yet unclassified' }
LuiCssClasses >> addCssClasses: anOrderedCollection [
	anOrderedCollection do: [ :eachCssClass |
		self addCssClass: eachCssClass ]
]

{ #category : #accessing }
LuiCssClasses >> cssClasses [
	^ cssClasses
]

{ #category : #accessing }
LuiCssClasses >> cssClasses: anObject [
	cssClasses := anObject
]

{ #category : #asking }
LuiCssClasses >> cssClassesString [
	| stream |
	stream := WriteStream on: String new.
	self cssClasses do: [:each | stream  nextPutAll: each ] separatedBy: [stream space].
	^stream contents
]

{ #category : #initialize }
LuiCssClasses >> initialize [
	super initialize.
	self cssClasses: OrderedCollection new.
]

{ #category : #action }
LuiCssClasses >> removeCssClass: aString [
	(self cssClasses includes: aString) ifFalse: [ self cssClasses remove: aString ]
]
