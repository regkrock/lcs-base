Class {
	#name : 'LuiVisibilityProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiVisibilityProperty class >> propertyName [
	^ 'visibility'
]

{ #category : 'command' }
LuiVisibilityProperty >> beHidden [
	self valueBlock: [ 'hidden' ]
]

{ #category : 'command' }
LuiVisibilityProperty >> beVisible [
	self valueBlock: [ 'visible' ]
]

{ #category : 'initialize' }
LuiVisibilityProperty >> initialize [
	super initialize.
	self valueBlock: [ 'visible' ]
]

{ #category : 'testing' }
LuiVisibilityProperty >> isHidden [
	^ self propertyValue = 'hidden'
]

{ #category : 'testing' }
LuiVisibilityProperty >> isVisible [
	^ self propertyValue = 'visible'
]
