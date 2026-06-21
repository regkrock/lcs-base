Class {
	#name : 'LuiMinAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiMinAttribute class >> attributeName [
	^ #min
]

{ #category : 'generated method' }
LuiMinAttribute >> min [
	^ self cachedValue
]

{ #category : 'generated method' }
LuiMinAttribute >> min: anObject [
	^ self valueBlock: [ anObject ]
]

{ #category : 'generated method' }
LuiMinAttribute >> tagAttributeSetterSelector [
	^ #min:
]
