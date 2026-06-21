Class {
	#name : 'LuiPlaceholderAttribute',
	#superclass : 'LuiComponentAttribute',
	#instVars : [
		'cssClasses'
	],
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant\t' }
LuiPlaceholderAttribute class >> attributeName [
	^ 'placeholder'
]

{ #category : 'initialize' }
LuiPlaceholderAttribute >> initialize [
	super initialize.
	self valueBlock: [ '' ]
]

{ #category : 'css classes' }
LuiPlaceholderAttribute >> placeholder [
	self cachedValue
]

{ #category : 'css classes' }
LuiPlaceholderAttribute >> placeholder: aString [
	self valueBlock: [ aString ]
]
