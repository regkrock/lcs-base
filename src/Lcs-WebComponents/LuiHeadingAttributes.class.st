Class {
	#name : 'LuiHeadingAttributes',
	#superclass : 'LuiComponentAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
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
