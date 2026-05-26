Class {
	#name : 'LuiAnchorAttributes',
	#superclass : 'LuiComponentAttributes',
	#traits : 'LuitCallbackAttribute',
	#classTraits : 'LuitCallbackAttribute classTrait',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'testig' }
LuiAnchorAttributes >> hasTargetAttribute [
	^ self hasAttribute: LuiTargetAttribute attributeName
]

{ #category : 'properties - accessing' }
LuiAnchorAttributes >> target [
	self hasTargetAttribute ifFalse: [ ^ nil ].
	^ self targetAttribute attributeValue
]

{ #category : 'properties - accessing' }
LuiAnchorAttributes >> target: aString [
	self targetAttribute value: aString
]

{ #category : 'attributes' }
LuiAnchorAttributes >> targetAttribute [
	^ self lazyInitializedAttribute: LuiTargetAttribute
]
