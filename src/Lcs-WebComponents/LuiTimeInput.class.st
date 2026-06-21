Class {
	#name : 'LuiTimeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiTimeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''time'''
]

{ #category : 'rendering' }
LuiTimeInput >> renderComponentOn: html [
	html timeInput
		addCommonAttributes: self;
		value: self displayValue
]
