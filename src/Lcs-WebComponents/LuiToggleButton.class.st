Class {
	#name : 'LuiToggleButton',
	#superclass : 'LuiButton',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiToggleButton >> initialize [
	super initialize
]

{ #category : 'rendering' }
LuiToggleButton >> onClick: html [
	"This needs work - this is just a placeholder"
	self onClick: (html jQuery ajax callback: [:v | self halt])
]
