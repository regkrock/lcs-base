Class {
	#name : 'LuiSaveAndCancelButtonBar',
	#superclass : 'LuiButtonBar',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiSaveAndCancelButtonBar >> defaultCssClasses [
	^ OrderedCollection with: 'buttonBar'
]

{ #category : 'initialize' }
LuiSaveAndCancelButtonBar >> initialize [
	super initialize.
	self addComponent: (LuiSaveButton new).
	self addComponent: (LuiCancelButton new)
]
