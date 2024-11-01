Class {
	#name : #LuiPushButton,
	#superclass : #LuiButton,
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #initialize }
LuiPushButton >> beButtonType [
	self buttonTypeProperty beButtonType
]

{ #category : #initialize }
LuiPushButton >> beSubmitType [
	self buttonTypeProperty beSubmitType
]

{ #category : #initialize }
LuiPushButton >> buttonTypeProperty [
	^ self properties buttonTypeProperty
]

{ #category : #initialize }
LuiPushButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : #rendering }
LuiPushButton >> renderComponentOn: html [
	html button
		addCommonProperties: self;
		onClick: (html jQuery ajax callback: [:v | self halt]);
		"value: 'button'"
		with: [ self components do: [ :eachComponent | html render: eachComponent ] ]
]
