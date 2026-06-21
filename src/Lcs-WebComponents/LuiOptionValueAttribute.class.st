Class {
	#name : 'LuiOptionValueAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constants' }
LuiOptionValueAttribute class >> attributeName [
	^ 'optionValue'
]

{ #category : 'initialize' }
LuiOptionValueAttribute >> initialize [
	super initialize.
	self tagAttributeSetterSelector: #value:
]

{ #category : 'accessing' }
LuiOptionValueAttribute >> name: aString [
	self valueBlock: [ aString ]
]

{ #category : 'accessing' }
LuiOptionValueAttribute >> optionValue [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiOptionValueAttribute >> optionValue: aString [
	self valueBlock: [ aString ]
]
