Class {
	#name : 'LuiAbstractTextAreaAttributes',
	#superclass : 'LuiFormInputAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaAttributes >> autocomplete [
	self hasAutocompleteAttribute ifFalse: [ ^ nil ].
	^ self autocompleteAttribute autocomplete
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaAttributes >> autocomplete: aString [
	^ self autocompleteAttribute autocomplete: aString
]

{ #category : 'attributes' }
LuiAbstractTextAreaAttributes >> autocompleteAttribute [
	^ self lazyInitializedAttribute: LuiAutocompleteAttribute
]

{ #category : 'testing' }
LuiAbstractTextAreaAttributes >> hasAutocompleteAttribute [
	^ self hasAttribute: LuiAutocompleteAttribute attributeName
]

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
