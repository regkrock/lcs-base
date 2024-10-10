Class {
	#name : #LuiStyleProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiStyleProperty class >> propertyName [
	^ 'style'
]

{ #category : #'as yet unclassified' }
LuiStyleProperty >> appendToStyle: aString [
	| newString |
	newString := self propertyValue , aString.
	self valueBlock: [ newString  ]
]

{ #category : #initialize }
LuiStyleProperty >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : #'as yet unclassified' }
LuiStyleProperty >> style: aString [
	self valueBlock: [ aString ]
]

{ #category : #'as yet unclassified' }
LuiStyleProperty >> styleBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : #'as yet unclassified' }
LuiStyleProperty >> value: aString [
	self valueBlock: [ aString ]
]
