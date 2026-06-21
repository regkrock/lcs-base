Class {
	#name : 'LuiAbstractTextAreaAttributes',
	#superclass : 'LuiFormInputAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'testing' }
LuiAbstractTextAreaAttributes >> hasPlaceholderAttribute [
	^ self hasAttribute: LuiPlaceholderAttribute attributeName
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaAttributes >> placeholder [
	self hasPlaceholderAttribute ifFalse: [ ^ nil ].
	^ self placeholderAttribute placeholder
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaAttributes >> placeholder: aString [
	^ self placeholderAttribute placeholder: aString
]

{ #category : 'attributes' }
LuiAbstractTextAreaAttributes >> placeholderAttribute [
	^ self lazyInitializedAttribute: LuiPlaceholderAttribute
]
