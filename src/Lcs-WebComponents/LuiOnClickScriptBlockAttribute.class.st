Class {
	#name : 'LuiOnClickScriptBlockAttribute',
	#superclass : 'LuiJavascriptAttribute',
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

{ #category : 'rendering' }
LuiOnClickScriptBlockAttribute >> attributeObjectForTag: aTagBrush [ 
	^ aTagBrush canvas jQuery ajax script: self cachedValue
]

{ #category : 'initialize' }
LuiOnClickScriptBlockAttribute >> initialize [
	super initialize.
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
