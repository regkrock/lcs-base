Class {
	#name : #LuiMainPage,
	#superclass : #LuiPage,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiMainPage >> initialize [
	super initialize.
	self addComponent: (LuiMainMenuBar on: self).
	self addComponent: (LuiButtonBar on: self).
	self addComponent:(LuiApplicationArea on: self)
]
