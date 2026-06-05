Class {
	#name : 'LuiFormInputAttributes',
	#superclass : 'LuiComponentAttributes',
	#traits : 'LuitNameAttribute',
	#classTraits : 'LuitNameAttribute classTrait',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'testing' }
LuiFormInputAttributes >> hasPlaceholderAttribute [
	^ self hasAttribute: LuiPlaceholderAttribute attributeName
]

{ #category : 'attributes - accessing' }
LuiFormInputAttributes >> placeholder [
	self hasPlaceholderAttribute ifFalse: [ ^ nil ].
	^ self placeholderAttribute placeholder
]

{ #category : 'attributes' }
LuiFormInputAttributes >> placeholderAttribute [
	^ self lazyInitializedAttribute: LuiPlaceholderAttribute
]
