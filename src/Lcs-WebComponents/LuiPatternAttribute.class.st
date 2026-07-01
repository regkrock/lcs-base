Class {
	#name : 'LuiPatternAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiPatternAttribute class >> attributeName [
	^ #pattern
]

{ #category : 'generated method' }
LuiPatternAttribute >> pattern [
	^ self cachedValue
]

{ #category : 'generated method' }
LuiPatternAttribute >> pattern: anObject [
	^ self valueBlock: [ anObject ]
]

{ #category : 'generated method' }
LuiPatternAttribute >> tagAttributeSetterSelector [
	^ #pattern:
]
