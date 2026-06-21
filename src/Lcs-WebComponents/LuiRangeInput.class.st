Class {
	#name : 'LuiRangeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiRangeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''range'''
]

{ #category : 'rendering' }
LuiRangeInput >> renderComponentOn: html [
	html rangeInput
		addCommonAttributes: self;
		value: self displayValue
]
