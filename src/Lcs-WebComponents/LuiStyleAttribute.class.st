Class {
	#name : 'LuiStyleAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiStyleAttribute class >> attributeName [
	^ 'style'
]

{ #category : 'as yet unclassified' }
LuiStyleAttribute >> appendToStyle: aString [
	| newString |
	newString := self attributeValue , aString.
	self valueBlock: [ newString  ]
]

{ #category : 'initialize' }
LuiStyleAttribute >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : 'as yet unclassified' }
LuiStyleAttribute >> style: aString [
	self valueBlock: [ aString ]
]

{ #category : 'as yet unclassified' }
LuiStyleAttribute >> styleBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'as yet unclassified' }
LuiStyleAttribute >> value: aString [
	self valueBlock: [ aString ]
]
