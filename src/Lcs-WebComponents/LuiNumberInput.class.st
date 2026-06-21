Class {
	#name : 'LuiNumberInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiNumberInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''number'''
]

{ #category : 'rendering' }
LuiNumberInput >> renderComponentOn: html [
	html numberInput
		addCommonAttributes: self;
		value: self displayValue
]
