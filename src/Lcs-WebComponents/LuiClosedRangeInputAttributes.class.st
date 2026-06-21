Class {
	#name : 'LuiClosedRangeInputAttributes',
	#superclass : 'LuiSteppedInputAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> hasMaxAttribute [
	^ self hasAttribute: LuiMaxAttribute attributeName
]

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> hasMinAttribute [
	^ self hasAttribute: LuiMinAttribute attributeName
]

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> max [
	self hasMaxAttribute ifFalse: [ ^ nil ].
	^ self maxAttribute attributeValue
]

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> max: anObject [
	self maxAttribute max: anObject
]

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> maxAttribute [
	^ self lazyInitializedAttribute: LuiMaxAttribute
]

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> min [
	self hasMinAttribute ifFalse: [ ^ nil ].
	^ self minAttribute attributeValue
]

{ #category : 'as yet unclassified' }
LuiClosedRangeInputAttributes >> min: anInteger [
	self minAttribute value: anInteger
]

{ #category : 'generated method' }
LuiClosedRangeInputAttributes >> minAttribute [
	^ self lazyInitializedAttribute: LuiMinAttribute
]
