Trait {
	#name : 'LuitOptionValueAttribute',
	#category : 'Lcs-WebComponents-Traits',
	#package : 'Lcs-WebComponents',
	#tag : 'Traits'
}

{ #category : 'testing' }
LuitOptionValueAttribute >> hasOptionValueAttribute [
	^ self hasAttribute: LuiOptionValueAttribute attributeName
]

{ #category : 'attributes - accessing' }
LuitOptionValueAttribute >> optionValue [
	self hasOptionValueAttribute ifFalse: [ ^ nil ].
	^ self optionValueAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuitOptionValueAttribute >> optionValue: aString [
	self optionValueAttribute name: aString
]

{ #category : 'attributes' }
LuitOptionValueAttribute >> optionValueAttribute [
	^ self lazyInitializedAttribute: LuiOptionValueAttribute
]
