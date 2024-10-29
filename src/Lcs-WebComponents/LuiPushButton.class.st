Class {
	#name : #LuiPushButton,
	#superclass : #LuiButton,
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #initialize }
LuiPushButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : #rendering }
LuiPushButton >> renderComponentOn: html [
	html button
		addCommonProperties: self;
		onClick: ((html jQuery ajax) callback: [self showLabelOnTranscript ]);
		value: 'button'
		"with: [ self components do: [ :eachComponent | html render: eachComponent ] ]"
]
