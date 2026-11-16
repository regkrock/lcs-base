Class {
	#name : 'LuiOnClickScriptBlockAttribute',
	#superclass : 'LuiJavascriptAttribute',
	#instVars : [
		'actionBlock',
		'updateBlocks'
	],
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'defaults' }
LuiOnClickScriptBlockAttribute class >> attributeName [
	^ 'onClickScriptBlock'
]

{ #category : 'private' }
LuiOnClickScriptBlockAttribute >> _attributeValue [
	^ self valueBlock
]

{ #category : 'accessing' }
LuiOnClickScriptBlockAttribute >> actionBlock [
	^ actionBlock
]

{ #category : 'accessing' }
LuiOnClickScriptBlockAttribute >> actionBlock: anObject [
	actionBlock := anObject
]

{ #category : 'rendering' }
LuiOnClickScriptBlockAttribute >> attributeObjectForTag: aTagBrush [ 
	^ aTagBrush canvas jQuery ajax script: self cachedValue
]

{ #category : 'updating' }
LuiOnClickScriptBlockAttribute >> execute: anActionBlock update: aComponentBlock [
	self execute: anActionBlock updating: (Array with: aComponentBlock)
]

{ #category : 'updating' }
LuiOnClickScriptBlockAttribute >> execute: anActionBlock update: aComponentBlock update: aComponentBlock2 [
	self
		execute: anActionBlock
		updating: (Array with: aComponentBlock with: aComponentBlock2)
]

{ #category : 'updating' }
LuiOnClickScriptBlockAttribute >> execute: anActionBlock updating: aComponents [
	self actionBlock: anActionBlock.
	self updateBlocks addAll: aComponents.
	self valueBlock: [ :s |
		self actionBlock value.
		self updateBlocks do: [ :eachBlock |
			s << ((s jQuery: eachBlock value parentComponent componentIdSelector)
						html: [ :r | r render: eachBlock value ]) ] ]

]

{ #category : 'initialize' }
LuiOnClickScriptBlockAttribute >> initialize [
	super initialize.
	self updateBlocks: OrderedCollection new.
	self tagAttributeSetterSelector: #onClick:
]

{ #category : 'accessing' }
LuiOnClickScriptBlockAttribute >> onClickScriptBlock [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiOnClickScriptBlockAttribute >> onClickScriptBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'accessing' }
LuiOnClickScriptBlockAttribute >> updateBlocks [
	^ updateBlocks
]

{ #category : 'accessing' }
LuiOnClickScriptBlockAttribute >> updateBlocks: anObject [
	updateBlocks := anObject
]
