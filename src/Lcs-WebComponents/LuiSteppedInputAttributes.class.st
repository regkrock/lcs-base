Class {
	#name : 'LuiSteppedInputAttributes',
	#superclass : 'LuiAbstractTextAreaAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiSteppedInputAttributes >> hasStepAttribute [
	^ self hasAttribute: LuiStepAttribute attributeName
]

{ #category : 'generated method' }
LuiSteppedInputAttributes >> step [
	self hasStepAttribute ifFalse: [ ^ nil ].
	^ self stepAttribute attributeValue
]

{ #category : 'generated method' }
LuiSteppedInputAttributes >> step: anObject [
	self stepAttribute step: anObject
]

{ #category : 'generated method' }
LuiSteppedInputAttributes >> stepAttribute [
	^ self lazyInitializedAttribute: LuiStepAttribute
]
