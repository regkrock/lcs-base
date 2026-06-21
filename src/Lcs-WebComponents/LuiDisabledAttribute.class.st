Class {
	#name : 'LuiDisabledAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'as yet unclassified' }
LuiDisabledAttribute class >> attributeName [
	^ 'disabled'
]

{ #category : 'command' }
LuiDisabledAttribute >> beDisabled [
	self valueBlock: [ true ]
]

{ #category : 'command' }
LuiDisabledAttribute >> beEnabled [
	self valueBlock: [ false ]
]

{ #category : 'accessing' }
LuiDisabledAttribute >> disabled [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiDisabledAttribute >> disabled: aBoolean [
	self valueBlock: [ aBoolean ] 
]

{ #category : 'initialize' }
LuiDisabledAttribute >> initialize [
	super initialize.
	self valueBlock: [ false ]
]

{ #category : 'as yet unclassified' }
LuiDisabledAttribute >> isDisabled [
	^ self attributeValue == true
]

{ #category : 'as yet unclassified' }
LuiDisabledAttribute >> isEnabled [
	^ self isDisabled not
]
