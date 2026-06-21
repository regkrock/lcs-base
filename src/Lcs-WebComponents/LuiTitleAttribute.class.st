Class {
	#name : 'LuiTitleAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant' }
LuiTitleAttribute class >> attributeName [
	^ 'title'
]

{ #category : 'initialize' }
LuiTitleAttribute >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : 'property' }
LuiTitleAttribute >> title [
	^ self cachedValue
]

{ #category : 'property' }
LuiTitleAttribute >> title: aString [
	self valueBlock: [ aString ]
]

{ #category : 'property' }
LuiTitleAttribute >> titleBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'property' }
LuiTitleAttribute >> value: aString [
	self valueBlock: [ aString ]
]
