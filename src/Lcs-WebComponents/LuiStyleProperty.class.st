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
	self valueBlock: [ self propertyValue , aString  ]
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
