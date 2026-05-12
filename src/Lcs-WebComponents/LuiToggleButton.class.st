Class {
	#name : 'LuiToggleButton',
	#superclass : 'LuiButton',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'configuration' }
LuiToggleButton >> beButtonType [
	self buttonTypeAttribute beButtonType
]

{ #category : 'configuration' }
LuiToggleButton >> beSubmitType [
	self buttonTypeAttribute beSubmitType
]

{ #category : 'as yet unclassified' }
LuiToggleButton >> buttonTypeAttribute [
	^ self attributes buttonTypeAttribute
]

{ #category : 'as yet unclassified' }
LuiToggleButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : 'rendering' }
LuiToggleButton >> renderComponentOn: html [
	<TODO: 'needs more work'>
	html button
		addCommonAttributes: self;
		onClick: (html jQuery ajax callback: [:v | self halt]);
		with: [ self components do: [ :eachComponent | html render: eachComponent ] ]
]
