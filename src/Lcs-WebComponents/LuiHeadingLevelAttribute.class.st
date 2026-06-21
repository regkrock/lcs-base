Class {
	#name : 'LuiHeadingLevelAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiHeadingLevelAttribute class >> attributeName [
	^ #headingLevel
]

{ #category : 'generated method' }
LuiHeadingLevelAttribute >> headingLevel [
	^ self cachedValue
]

{ #category : 'generated method' }
LuiHeadingLevelAttribute >> headingLevel: anObject [
	^ self valueBlock: [ anObject ]
]

{ #category : 'generated method' }
LuiHeadingLevelAttribute >> tagAttributeSetterSelector [
	^ #level:
]
