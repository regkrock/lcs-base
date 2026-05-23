Class {
	#name : 'LuiOption',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'rendering' }
LuiOption >> renderComponentOn: html [
	html option
		selected: false;
		label: self;
		value: self
]
