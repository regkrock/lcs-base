Class {
	#name : 'LuiTextInputAttributes',
	#superclass : 'LuiAbstractTextAreaAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'testing' }
LuiTextInputAttributes >> hasPatternAttribute [
	^ self hasAttribute: LuiPatternAttribute attributeName
]

{ #category : 'accessing' }
LuiTextInputAttributes >> pattern [
	self hasPatternAttribute ifFalse: [ ^ nil ].
	^ self patternAttribute pattern
]

{ #category : 'accessing' }
LuiTextInputAttributes >> pattern: aString [
	^ self patternAttribute pattern: aString
]

{ #category : 'accessing' }
LuiTextInputAttributes >> patternAttribute [
	^ self lazyInitializedAttribute: LuiPatternAttribute
]
