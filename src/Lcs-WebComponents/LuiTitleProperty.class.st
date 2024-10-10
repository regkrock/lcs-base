Class {
	#name : #LuiTitleProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiTitleProperty class >> propertyName [
	^ 'title'
]

{ #category : #initialize }
LuiTitleProperty >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : #'as yet unclassified' }
LuiTitleProperty >> title: aString [
	self valueBlock: [ aString ]
]

{ #category : #'as yet unclassified' }
LuiTitleProperty >> titleBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : #'as yet unclassified' }
LuiTitleProperty >> value: aString [
	self valueBlock: [ aString ]
]
