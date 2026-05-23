Class {
	#name : 'LuiTargetAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
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
