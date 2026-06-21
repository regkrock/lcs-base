Class {
	#name : 'LuiMaxAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiMaxAttribute class >> attributeName [
	^ #max
]

{ #category : 'generated method' }
LuiMaxAttribute >> max [
	^ self cachedValue
]

{ #category : 'generated method' }
LuiMaxAttribute >> max: anObject [
	^ self valueBlock: [ anObject ]
]

{ #category : 'generated method' }
LuiMaxAttribute >> tagAttributeSetterSelector [
	^ #max:
]
