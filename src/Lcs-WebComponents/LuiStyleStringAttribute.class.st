Class {
	#name : 'LuiStyleStringAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant' }
LuiStyleStringAttribute class >> attributeName [
	^ 'style'
]

{ #category : 'as yet unclassified' }
LuiStyleStringAttribute >> appendToStyleString: aString [
	| newString |
	newString := self attributeValue , aString.
	self valueBlock: [ newString  ]
]

{ #category : 'initialize' }
LuiStyleStringAttribute >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : 'as yet unclassified' }
LuiStyleStringAttribute >> styleBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'accessing' }
LuiStyleStringAttribute >> styleString [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiStyleStringAttribute >> styleString: aString [
	self valueBlock: [ aString ]
]

{ #category : 'as yet unclassified' }
LuiStyleStringAttribute >> value: aString [
	self valueBlock: [ aString ]
]
