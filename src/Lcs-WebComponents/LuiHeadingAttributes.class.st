Class {
	#name : 'LuiHeadingAttributes',
	#superclass : 'LuiComponentAttributes',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'generated method' }
LuiHeadingAttributes >> hasHeadingLevelAttribute [
	^ self hasAttribute: LuiHeadingLevelAttribute attributeName
]

{ #category : 'generated method' }
LuiHeadingAttributes >> headingLevel [
	self hasHeadingLevelAttribute ifFalse: [ ^ nil ].
	^ self headingLevelAttribute attributeValue 
]

{ #category : 'generated method' }
LuiHeadingAttributes >> headingLevel: anObject [
	self headingLevelAttribute headingLevel: anObject
]

{ #category : 'generated method' }
LuiHeadingAttributes >> headingLevelAttribute [
	^ self lazyInitializedAttribute: LuiHeadingLevelAttribute
]
