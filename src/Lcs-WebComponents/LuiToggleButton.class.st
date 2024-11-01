Class {
	#name : #LuiToggleButton,
	#superclass : #LuiButton,
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #configuration }
LuiToggleButton >> beButtonType [
	self buttonTypeProperty beButtonType
]

{ #category : #configuration }
LuiToggleButton >> beSubmitType [
	self buttonTypeProperty beSubmitType
]

{ #category : #'as yet unclassified' }
LuiToggleButton >> buttonTypeProperty [
	^ self properties buttonTypeProperty
]

{ #category : #'as yet unclassified' }
LuiToggleButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : #rendering }
LuiToggleButton >> renderComponentOn: html [
	<TODO: 'needs more work'>
	html button
		addCommonProperties: self;
		onClick: (html jQuery ajax callback: [:v | self halt]);
		with: [ self components do: [ :eachComponent | html render: eachComponent ] ]
]
