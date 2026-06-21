Class {
	#name : 'LuiImageAttributes',
	#superclass : 'LuiComponentAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'properties - delegated' }
LuiImageAttributes >> altText [
	self hasAltTextAttribute ifFalse: [ ^ nil ].
	^ self altTextAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiImageAttributes >> altText: aString [
	^ self altTextAttribute altText: aString
]

{ #category : 'properties - defined' }
LuiImageAttributes >> altTextAttribute [
	^ self lazyInitializedAttribute: LuiAltTextAttribute
]

{ #category : 'properties - testing' }
LuiImageAttributes >> hasAltTextAttribute [
	^ self hasAttribute: LuiAltTextAttribute attributeName
]
