Class {
	#name : 'LuiStepAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiStepAttribute class >> attributeName [
	^ #step
]

{ #category : 'generated method' }
LuiStepAttribute >> step [
	^ self cachedValue
]

{ #category : 'generated method' }
LuiStepAttribute >> step: anObject [
	^ self valueBlock: [ anObject ]
]

{ #category : 'generated method' }
LuiStepAttribute >> tagAttributeSetterSelector [
	^ #step:
]
