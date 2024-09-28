Class {
	#name : #LuiMainPage,
	#superclass : #LuiPage,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiMainPage >> initialize [
	super initialize.
	self addComponent: (LuiMainMenu named: 'navigation' on: self).
	self addComponent:  (LuiButtonBar named: 'actionBar' on: self).
	self addComponent: (LuiApplicationArea named: 'application' on: self).
]
