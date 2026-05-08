Class {
	#name : 'LuiPage',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiPage >> headerComponent [
	^ self
		componentNamed: self headerComponentName
		ifNil: [ self addComponent: (LuiPageHeader named: self headerComponentName) ]
]

{ #category : 'component names' }
LuiPage >> headerComponentName [
	^ 'header'
]

{ #category : 'updating' }
LuiPage >> pageTitle: aString [
	self headerComponent pageTitle: aString
]
