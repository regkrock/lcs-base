Class {
	#name : 'LuiSelectOptionAttributes',
	#superclass : 'LuiFormInputAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'attributes - accessing' }
LuiSelectOptionAttributes >> hasHtmlTagValueAttribute [
	^ self hasAttribute: LuiHtmlTagValueAttribute attributeName
]

{ #category : 'attributes - accessing' }
LuiSelectOptionAttributes >> htmlTagValue [
	self hasHtmlTagValueAttribute ifFalse: [ ^ nil ].
	^ self htmlTagValueAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiSelectOptionAttributes >> htmlTagValue: aString [
	self htmlTagValueAttribute htmlTagValue: aString
]

{ #category : 'attributes' }
LuiSelectOptionAttributes >> htmlTagValueAttribute [
	^ self lazyInitializedAttribute: LuiHtmlTagValueAttribute
]
