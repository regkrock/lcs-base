Class {
	#name : 'LuiOption',
	#superclass : 'LuiFormInputComponent',
	#instVars : [
		'optionValue'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'accessing' }
LuiOption >> optionValue [
	^ optionValue
]

{ #category : 'accessing' }
LuiOption >> optionValue: anObject [
	optionValue := anObject
]

{ #category : 'rendering' }
LuiOption >> renderComponentOn: html [
	html option
		selected: false;
		value: self optionValue;
		with: [ html text: self text ]
]
