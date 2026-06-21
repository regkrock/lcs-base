Class {
	#name : 'LuiTargetAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant' }
LuiTargetAttribute class >> attributeName [
	^ 'target'
]

{ #category : 'commands' }
LuiTargetAttribute >> beBlankTarget [
	self target: '_blank'
]

{ #category : 'initialize' }
LuiTargetAttribute >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : 'property' }
LuiTargetAttribute >> target [
	^ self cachedValue
]

{ #category : 'property' }
LuiTargetAttribute >> target: aString [
	self valueBlock: [ aString ]
]

{ #category : 'property' }
LuiTargetAttribute >> targetBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'property' }
LuiTargetAttribute >> value: aString [
	self valueBlock: [ aString ]
]
