Class {
	#name : 'LuiFormInputAttributes',
	#superclass : 'LuiModelWidgetAttributes',
	#traits : 'LuitNameAttribute',
	#classTraits : 'LuitNameAttribute classTrait',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'commands' }
LuiFormInputAttributes >> beReadOnly [
	self readOnly: true
]

{ #category : 'generated method' }
LuiFormInputAttributes >> hasReadOnlyAttribute [
	^ self hasAttribute: LuiReadOnlyAttribute attributeName
]

{ #category : 'generated method' }
LuiFormInputAttributes >> readOnly [
	self hasReadOnlyAttribute ifFalse: [ ^ nil ].
	^ self readOnlyAttribute attributeValue
]

{ #category : 'generated method' }
LuiFormInputAttributes >> readOnly: anObject [
	self readOnlyAttribute readOnly: anObject
]

{ #category : 'generated method' }
LuiFormInputAttributes >> readOnlyAttribute [
	^ self lazyInitializedAttribute: LuiReadOnlyAttribute
]
