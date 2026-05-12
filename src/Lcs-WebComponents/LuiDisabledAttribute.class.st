Class {
	#name : 'LuiDisabledAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
LuiDisabledAttribute class >> attributeName [
	^ 'dsiabled'
]

{ #category : 'command' }
LuiDisabledAttribute >> beDisabled [
	self valueBlock: [ true ]
]

{ #category : 'command' }
LuiDisabledAttribute >> beEnabled [
	self valueBlock: [ false ]
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
