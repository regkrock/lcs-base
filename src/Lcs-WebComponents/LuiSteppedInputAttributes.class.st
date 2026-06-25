Class {
	#name : 'LuiSteppedInputAttributes',
	#superclass : 'LuiAbstractTextAreaAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'testing' }
LuiSteppedInputAttributes >> hasMaxAttribute [
	^ self hasAttribute: LuiMaxAttribute attributeName
]

{ #category : 'testing' }
LuiSteppedInputAttributes >> hasMinAttribute [
	^ self hasAttribute: LuiMinAttribute attributeName
]

{ #category : 'generated method' }
LuiSteppedInputAttributes >> hasStepAttribute [
	^ self hasAttribute: LuiStepAttribute attributeName
]

{ #category : 'attributes - accessing' }
LuiSteppedInputAttributes >> max [
	self hasMaxAttribute ifFalse: [ ^ nil ].
	^ self maxAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiSteppedInputAttributes >> max: anObject [
	self maxAttribute max: anObject
]

{ #category : 'attribute' }
LuiSteppedInputAttributes >> maxAttribute [
	^ self lazyInitializedAttribute: LuiMaxAttribute
]

{ #category : 'attributes - accessing' }
LuiSteppedInputAttributes >> min [
	self hasMinAttribute ifFalse: [ ^ nil ].
	^ self minAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiSteppedInputAttributes >> min: anInteger [
	self minAttribute min: anInteger
]

{ #category : 'attributes' }
LuiSteppedInputAttributes >> minAttribute [
	^ self lazyInitializedAttribute: LuiMinAttribute
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
