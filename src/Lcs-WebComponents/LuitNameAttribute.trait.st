Trait {
	#name : 'LuitNameAttribute',
	#category : 'Lcs-WebComponents-Traits',
	#package : 'Lcs-WebComponents',
	#tag : 'Traits'
}

{ #category : 'testing' }
LuitNameAttribute >> hasNameAttribute [
	^ self hasAttribute: LuiNameAttribute attributeName
]

{ #category : 'attributes - accessing' }
LuitNameAttribute >> name [
	self hasNameAttribute ifFalse: [ ^ nil ].
	^ self nameAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuitNameAttribute >> name: aString [
	self nameAttribute name: aString
]

{ #category : 'attributes' }
LuitNameAttribute >> nameAttribute [
	^ self lazyInitializedAttribute: LuiNameAttribute
]
