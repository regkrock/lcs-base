Trait {
	#name : 'LuitCallbackAttribute',
	#category : 'Lcs-WebComponents-Traits',
	#package : 'Lcs-WebComponents',
	#tag : 'Traits'
}

{ #category : 'attributes - accessing' }
LuitCallbackAttribute >> callback [
	self hasCallbackAttribute ifFalse: [ ^ nil ].
	^ self callbackAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuitCallbackAttribute >> callback: aBlock [
	self callbackAttribute callback: aBlock
]

{ #category : 'attributes' }
LuitCallbackAttribute >> callbackAttribute [
	^ self lazyInitializedAttribute: LuiCallbackAttribute
]

{ #category : 'testing' }
LuitCallbackAttribute >> hasCallbackAttribute [
	^ self hasAttribute: LuiCallbackAttribute attributeName
]
