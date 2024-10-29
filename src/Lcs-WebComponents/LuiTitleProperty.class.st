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

{ #category : #property }
LuiTitleProperty >> title [
	^ self cachedValue
]

{ #category : #property }
LuiTitleProperty >> title: aString [
	self valueBlock: [ aString ]
]

{ #category : #property }
LuiTitleProperty >> titleBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : #property }
LuiTitleProperty >> value: aString [
	self valueBlock: [ aString ]
]
