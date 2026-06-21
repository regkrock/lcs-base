Class {
	#name : 'LuiVisibilityAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant' }
LuiVisibilityAttribute class >> attributeName [
	^ 'visibility'
]

{ #category : 'command' }
LuiVisibilityAttribute >> beHidden [
	self valueBlock: [ 'hidden' ]
]

{ #category : 'command' }
LuiVisibilityAttribute >> beVisible [
	self valueBlock: [ 'visible' ]
]

{ #category : 'initialize' }
LuiVisibilityAttribute >> initialize [
	super initialize.
	self valueBlock: [ 'visible' ]
]

{ #category : 'testing' }
LuiVisibilityAttribute >> isHidden [
	^ self attributeValue = 'hidden'
]

{ #category : 'testing' }
LuiVisibilityAttribute >> isVisible [
	^ self attributeValue = 'visible'
]
