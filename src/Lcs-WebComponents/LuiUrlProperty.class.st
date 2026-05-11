Class {
	#name : 'LuiUrlProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiUrlProperty class >> propertyName [
	^ 'url'
]

{ #category : 'initialize' }
LuiUrlProperty >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : 'property' }
LuiUrlProperty >> url [
	^ self cachedValue
]

{ #category : 'property' }
LuiUrlProperty >> url: aString [
	self valueBlock: [ aString ]
]

{ #category : 'property' }
LuiUrlProperty >> urlBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'property' }
LuiUrlProperty >> value: aString [
	self valueBlock: [ aString ]
]
