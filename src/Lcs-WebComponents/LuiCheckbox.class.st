Class {
	#name : 'LuiCheckbox',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiCheckbox >> initialize [
	super initialize.
]

{ #category : 'rendering' }
LuiCheckbox >> isChecked [
	^ self model == true
]

{ #category : 'rendering' }
LuiCheckbox >> renderComponentOn: html [
	html checkbox
		addCommonAttributes: self;
		value: self isChecked;
		lcsText: self text
]
